//
//  ViewControllerNewPlan.swift
//  MapTrip
//
//  Created by 김민경 on 2022/12/04.
//

import Foundation
import UIKit

class ViewControllerNewPlan: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.masksToBounds = false
        titleTextField.layer.cornerRadius = 15
        titleTextField.clipsToBounds = true
        contentsView.layer.masksToBounds = false
        contentsView.layer.cornerRadius = 15
        contentsView.clipsToBounds = true
    }
}
