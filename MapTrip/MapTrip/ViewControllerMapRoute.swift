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
    var commercialPopUp2: NewPlanPopUp!
    
    struct State{
        let recommendRoute: String
        let recommendLocation: String
    }
    let States: [State] = [
        State(recommendRoute: "1,234m", recommendLocation: "LA 게티센터 - 파머스마켓 - LA 유니버셜스튜디오"),
        State(recommendRoute: "2,345", recommendLocation: "LA 게티센터 - LA 유니버셜스튜디오 - 파머스마켓")
    ]
    
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
    
    @IBAction func addPlan2(_ sender: Any) {
        self.commercialPopUp2 = NewPlanPopUp(frame: self.view.frame)
        self.commercialPopUp2.closeBtn.addTarget(self, action: #selector(closeBtnTapped2), for: .touchUpInside)
        self.commercialPopUp2.addBtn.addTarget(self, action: #selector(closeBtnTapped2), for: .touchUpInside)
        self.view.addSubview(commercialPopUp)
    }
    
    
    @objc func closeBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    @objc func addBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    @objc func closeBtnTapped2(){
        self.commercialPopUp2.removeFromSuperview()
    }
    @objc func addBtnTapped2(){
        self.commercialPopUp2.removeFromSuperview()
    }
}

