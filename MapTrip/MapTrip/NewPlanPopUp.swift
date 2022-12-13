//
//  NewPlanPopUp.swift
//  MapTrip
//
//  Created by 김민경 on 2022/12/10.
//

import UIKit

class NewPlanPopUp: UIView, UITextFieldDelegate {
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsView: UIView!
    
    @IBOutlet var startDateTimePicker: UIDatePicker!
    @IBOutlet var endDateTimePicker: UIDatePicker!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    let formatter = DateFormatter()
   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        popUpView.layer.masksToBounds = false
        popUpView.layer.cornerRadius = 20
        popUpView.clipsToBounds = true
        closeBtn.layer.masksToBounds = false
        closeBtn.layer.cornerRadius = 10
        closeBtn.clipsToBounds = true
        addBtn.layer.masksToBounds = false
        addBtn.layer.cornerRadius = 10
        addBtn.clipsToBounds = true
        titleTextField.layer.masksToBounds = false
        titleTextField.layer.cornerRadius = 15
        titleTextField.clipsToBounds = true
        contentsView.layer.masksToBounds = false
        contentsView.layer.cornerRadius = 15
        contentsView.clipsToBounds = true
        
        titleTextField.becomeFirstResponder()
        titleTextField.delegate = self
        
        
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
    
    @IBAction func startDateTimePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        print(formatter.string(from: datePickerView.date))
    }
    
    @IBAction func endDateTimePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        print(formatter.string(from: datePickerView.date))
    }
    // PopUP
    func xibSetup(frame: CGRect){
        let view = loadXid()
        view.frame = frame
        addSubview(view)
    }
        
    func loadXid() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NewPlanPopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view!
    }
   
    
    // text
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let text = textField.text
        print("\(text)")
        
        return true
    }
}
