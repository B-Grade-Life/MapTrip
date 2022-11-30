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
    
    var commercialPopUp: PopUp!
    
    
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
