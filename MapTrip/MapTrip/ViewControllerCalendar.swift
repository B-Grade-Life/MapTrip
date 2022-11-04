//
//  ViewControllerCalendar.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/28.
//

import Foundation
import UIKit

class ViewControllerCalendar: UIViewController {

    @IBOutlet var lblCurrentMonth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM"
        lblCurrentMonth.text = dateFormatter.string(from: date as Date)
    }

}

