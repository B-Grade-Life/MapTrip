//
//  PopUp.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/29.
//

import UIKit

class CreateGroupPopUp: UIView, UITextFieldDelegate {
    @IBOutlet var popupView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var addBtn: UIButton!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))

        popupView.layer.masksToBounds = false
        popupView.layer.cornerRadius = 20
        popupView.clipsToBounds = true
        closeBtn.layer.masksToBounds = false
        closeBtn.layer.cornerRadius = 10
        closeBtn.clipsToBounds = true
        addBtn.layer.masksToBounds = false
        addBtn.layer.cornerRadius = 10
        addBtn.clipsToBounds = true

        titleTextField.becomeFirstResponder()
        titleTextField.delegate = self
    }

    // PopUP
    func xibSetup(frame: CGRect){
        let view = loadXid()
        view.frame = frame
        addSubview(view)
    }

    func loadXid() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }

    // text
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let text = textField.text
        // print(text)
        return true
    }
    
    @IBAction func addBtnHandler(_ sender: Any) {
        // Home에 새로운 Group 추가.
        // -- 이미지, 그룹명을 정보를 제공.
        // 이미지는 사용자 휴대폰에서 받아옴. 필수요소는 아님.
        // 그룹명도 필수 요소는 아니며, 입력을 받지 못 했을 시, '새로운 그룹'이라는 명칭을 사용함.
    }
}
