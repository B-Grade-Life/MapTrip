//
//  ViewControllerCalendar.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/28.
//

import Foundation
import UIKit

class ViewControllerCalendar: UIViewController, UIApplicationDelegate {

    @IBOutlet var lblCurrentMonth: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var drawLine: UIImageView!
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMount = 0
    var weekdayAdding = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        // Do any additional setup after loading the view.
        
        let date = NSDate()
       
        dateFormatter.dateFormat = "MMM"
        lblCurrentMonth.text = dateFormatter.string(from: date as Date)
        
        //draw line
        UIGraphicsBeginImageContext(drawLine.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(3.0)
        context.setStrokeColor(red: 99/255, green: 138/255, blue: 102/255, alpha: 1)
        context.move(to: CGPoint(x: 8, y: 3))
        context.addLine(to: CGPoint(x: 8, y: 41))
        context.strokePath()
        
        drawLine.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    //view 초기화
    private func initView(){
        self.initCollection()
        
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        self.calculation()
        
    }
    //collectionView 초기화
    private func initCollection(){
        self.collectionView.delegate
        self.collectionView.dataSource
        self.collectionView.register(UINib(nibName: "CalendarCoeectionViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
//        self.collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:))))
    }
    private func calculation(){
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMount = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMount{
            if day < 1{
                self.days.append("")
            }else{
                self.days.append(String(day))
            }
        }
    }
    @IBAction func didTappedPrevBtn(_ sender: UIButton) {
        //이전달로 이동
        components.month = components.month! - 1
        self.calculation()
        self.collectionView.reloadData()
    }
    @IBAction func didTappedNextBtn(_ sender: UIButton) {
        //다음달로 이동
        components.month = components.month! + 1
        self.calculation()
        self.collectionView.reloadData()
    }
}

extension ViewControllerCalendar: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! ViewControllerCalendar
        
//        switch indexPath.section {
//        case 0:
//            cell.dateLabel.text = weeks[indexPath.row]
//        default:
//            cell.dateLabel.text = days[indexPath.row]
//        }
        
//        if indexPath.row % 7 == 0 {
//            cell.dateLabel.textColor = .red
//        } else if indexPath.row % 7 == 6 {
//            cell.dateLabel.textColor = .blue
//        } else {
//            cell.dateLabel.textColor = .black
//        }

//        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
        let cellSize : CGFloat = myBoundSize / 9
        return CGSize(width: cellSize, height: cellSize)
    }
}
