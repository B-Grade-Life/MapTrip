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
    @IBOutlet var switchBtn: UISwitch!
    
    @IBOutlet var startDateTimePicker: UIDatePicker!
    @IBOutlet var endDateTimePicker: UIDatePicker!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.masksToBounds = false
        titleTextField.layer.cornerRadius = 15
        titleTextField.clipsToBounds = true
        contentsView.layer.masksToBounds = false
        contentsView.layer.cornerRadius = 15
        contentsView.clipsToBounds = true
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if sender.isOn{
            startDateTimePicker.isHidden = true
            endDateTimePicker.isHidden = true
            startDatePicker.isHidden = false
            endDatePicker.isHidden = false
        }
        else{
            startDateTimePicker.isHidden = false
            endDateTimePicker.isHidden = false
            startDatePicker.isHidden = true
            endDatePicker.isHidden = true
        }
    }
}
