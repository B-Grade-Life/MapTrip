//
//  ViewControllerMapRoute.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/10.
//

import Foundation
import UIKit

class ViewControllerMapRoute: UIViewController {
    
    @IBOutlet var viewBestRoute: UIView!
    @IBOutlet var viewRoute: UIView!
    @IBOutlet var box1: UIImageView!
    @IBOutlet var box2: UIImageView!
    
    @IBOutlet var lblBestRoute: UILabel!
    @IBOutlet var lblBestRouteText: UILabel!
    @IBOutlet var lblRoute: UILabel!
    @IBOutlet var lblRouteText: UILabel!
    
    var bestRoute: String = ""
    var bestRouteText: String = ""
    var secRoute: String = ""
    var secRouteText: String = ""
    
 
    var commercialPopUp: NewPlanPopUp!
    var commercialPopUp2: NewPlanPopUp!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBestRoute.layer.masksToBounds = false
        viewBestRoute.layer.cornerRadius = 10
        viewBestRoute.clipsToBounds = true
        viewRoute.layer.masksToBounds = false
        viewRoute.layer.cornerRadius = 10
        viewRoute.clipsToBounds = true
        
        box1.layer.masksToBounds = false
        box1.layer.cornerRadius = 10
        box1.clipsToBounds = true
        box2.layer.masksToBounds = false
        box2.layer.cornerRadius = 10
        box2.clipsToBounds = true
        
        
        lblBestRoute.text = bestRoute + "m"
        lblBestRouteText.text = bestRouteText
        lblRoute.text = secRoute + "m"
        lblRouteText.text = secRouteText
    }
  
    @IBAction func addPlan(_ sender: Any) {
        self.commercialPopUp = NewPlanPopUp(frame: self.view.frame)
        self.commercialPopUp.closeBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.commercialPopUp.addBtn.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        self.view.addSubview(commercialPopUp)
    }
    
    @IBAction func addPlan2(_ sender: Any) {
        self.commercialPopUp2 = NewPlanPopUp(frame: self.view.frame)
        self.commercialPopUp2.closeBtn.addTarget(self, action: #selector(closeBtnTapped2), for: .touchUpInside)
        self.commercialPopUp2.addBtn.addTarget(self, action: #selector(addBtnTapped2), for: .touchUpInside)
        self.view.addSubview(commercialPopUp2)
    }
    
    
    @objc func closeBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    @objc func addBtnTapped(){
        print("aaa")
        requestPost4(url: "http://172.30.1.35:5642/calendar/insert", method: "POST",
                    param: [
                        "username": "gpstrio",
                        "title": "test",
                        "content": bestRouteText,
                        "from_date": "2022-12-22",
                        "to_date": "2022-12-23"
                    ])
        {(success, data) in
            print(data)
            print("ddd")
        }
        self.commercialPopUp.removeFromSuperview()
    }
    @objc func closeBtnTapped2(){
        self.commercialPopUp2.removeFromSuperview()
    }
    @objc func addBtnTapped2(){
        self.commercialPopUp2.removeFromSuperview()
    }
}

struct Data3: Codable {
    let username: String
    let title: String
    let content: String
    let from_date: Date
    let to_date: Date
}

func requestPost4(url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, Data3) -> Void) {
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
        guard let output = try? JSONDecoder().decode(Data3.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        
        completionHandler(true, output)
    }.resume()
}
