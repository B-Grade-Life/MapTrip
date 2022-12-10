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
    @IBOutlet var mainBoxRadius: UIView!
    @IBOutlet var boxRadius: UIView!
    
    var commercialPopUp: NewPlanPopUp!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBestRoute.layer.masksToBounds = false
        viewBestRoute.layer.cornerRadius = 10
        viewBestRoute.clipsToBounds = true
        
        viewRoute.layer.masksToBounds = false
        viewRoute.layer.cornerRadius = 10
        viewRoute.clipsToBounds = true
        
        mainBoxRadius.layer.masksToBounds = false
        mainBoxRadius.layer.cornerRadius = 10
        mainBoxRadius.clipsToBounds = true
        
        boxRadius.layer.masksToBounds = false
        boxRadius.layer.cornerRadius = 10
        boxRadius.clipsToBounds = true
    }
  
    @IBAction func addPlan(_ sender: Any) {
        self.commercialPopUp = NewPlanPopUp(frame: self.view.frame)
        self.commercialPopUp.closeBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.commercialPopUp.addBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.view.addSubview(commercialPopUp)
    }
    
    @objc func closeBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    @objc func addBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
}

