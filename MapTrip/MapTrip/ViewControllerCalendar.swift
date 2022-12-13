//
//  ViewControllerCalendar.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/28.
//

import Foundation
import UIKit

class ViewControllerCalendar: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var cornerView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var lblCurrentMonth: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //calednar
    var selectedDate = Date()
    var totalSquares = [String]()
   
    var content: String = ""
    var stringDate: String = ""

    var tableData: [table] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cornerView.layer.masksToBounds = false
        cornerView.layer.cornerRadius = 20
        cornerView.clipsToBounds = true
        
        //calendar
        setCellsView()
        setMonthView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        requestPost5(url: "http://172.30.1.35:5642/calendar/select", method: "POST", param: [
            "username": "gpstrio",
            "from_date": "2022-11-21"
        ])
        { (success, data) in
            self.content = data.content
            print(self.content)
            self.stringDate = data.date
        }
        sleep(1)
        print(self.content)
        print(self.stringDate)
        tableData = [table(content: self.content, date: self.stringDate)]
        //table.append(table(title: String, date: <#T##String#>))
        tableView.reloadData()
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.width - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()

        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)

        var count: Int = 1
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        lblCurrentMonth.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
//        let date = totalSquares[indexPath.item]
//        cell.dayOfMonth.text = String(CalendarHelper().daysOfMonth(date: date))
        
        
//        if(date == selectedDate)
//        {
//            cell.backgroundColor = UIColor(named: "Main Color")
//        }
//        else
//        {
//            cell.backgroundColor = UIColor.white
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }

    @IBAction func previousMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
    
    //table
    override func viewDidLayoutSubviews() {
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewPlanTableViewCell", for: indexPath) as! NewPlanTableViewCell
        
        cell.setup(with: tableData[indexPath.row])
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}

struct Data5 : Codable {
    let content: String
    let date: String
}

func requestPost5(url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, Data5) -> Void) {
    let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
    
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = sendData
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        guard let output = try? JSONDecoder().decode(Data5.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        
        completionHandler(true, output)
    }.resume()
}

