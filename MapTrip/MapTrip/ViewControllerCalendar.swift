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

    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let date = NSDate()
       
        dateFormatter.dateFormat = "MMM"
        lblCurrentMonth.text = dateFormatter.string(from: date as Date)
    }
}
