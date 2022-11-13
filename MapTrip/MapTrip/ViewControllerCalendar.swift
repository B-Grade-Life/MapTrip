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
    @IBOutlet var drawLine: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM"
        lblCurrentMonth.text = dateFormatter.string(from: date as Date)
        
        UIGraphicsBeginImageContext(drawLine.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(3.0)
//        context.setFillColor(UIColor.green.cgColor)
        context.setStrokeColor(red: 99/255, green: 138/255, blue: 102/255, alpha: 1)
        context.move(to: CGPoint(x: 8, y: 3))
        context.addLine(to: CGPoint(x: 8, y: 41))
        context.strokePath()
        
        drawLine.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }

}

