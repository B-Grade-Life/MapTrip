//
//  ViewControllerHome.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/03.
//

import Foundation
import UIKit

class ViewControllerHome: UIViewController {

    @IBOutlet var cornerView: UIView!
    @IBOutlet var scheduleCornerView: UIView!
    @IBOutlet var contentCornerView: UIView!
    @IBOutlet var contentCornerView2: UIView!
    @IBOutlet var contentCornerView3: UIView!
    
    @IBOutlet var lblCurrentWeekday: UILabel!
    @IBOutlet var lblCurrentDays: UILabel!
    
    @IBOutlet var drawRectangle: UIImageView!
    
    var commercialPopUp: PopUp!
    @IBOutlet var addGroupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let date = NSDate()
        let dateFormatterWeekday = DateFormatter()
        let dateFormatterDays = DateFormatter()
        
        cornerView.layer.masksToBounds = false
        cornerView.layer.cornerRadius = 20
        cornerView.clipsToBounds = true
        
        scheduleCornerView.layer.masksToBounds = false
        scheduleCornerView.layer.cornerRadius = 5
        scheduleCornerView.clipsToBounds = true
        
        contentCornerView.layer.masksToBounds = false
        contentCornerView.layer.cornerRadius = 15
        contentCornerView.clipsToBounds = true
        contentCornerView2.layer.masksToBounds = false
        contentCornerView2.layer.cornerRadius = 15
        contentCornerView2.clipsToBounds = true
        contentCornerView3.layer.masksToBounds = false
        contentCornerView3.layer.cornerRadius = 15
        contentCornerView3.clipsToBounds = true
        

        dateFormatterWeekday.dateFormat = "EEE"
        dateFormatterDays.dateFormat = "d"
        lblCurrentWeekday.text = dateFormatterWeekday.string(from: date as Date) + "요일"
        lblCurrentDays.text = dateFormatterDays.string(from: date as Date) +  "일"
        
        UIGraphicsBeginImageContext(drawRectangle.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        //사각형 그리고 색채우기
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.white.cgColor)
        context.setFillColor(UIColor.white.cgColor)
        
        let rectangle = CGRect(x: 0, y: 0, width: 157, height: 111)
        context.addRect(rectangle)
        context.fill(rectangle)
        context.strokePath()
        
        drawRectangle.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func addGroupTapped(_ sender: Any) {
        
        self.commercialPopUp = PopUp(frame: self.view.frame)
        self.commercialPopUp.closeBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.view.addSubview(commercialPopUp)
    }
    @objc func closeBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    
}
