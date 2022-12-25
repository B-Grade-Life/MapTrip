//
//  ViewControllerSignup.swift
//  MapTrip
//
//  Created by david-laugh(Lee Gyu Hyuk) on 2022/12/24.
//

import UIKit


class ViewControllerSignup: UIViewController {
    @IBOutlet weak var __name: UITextField!
    @IBOutlet weak var __birthday: UITextField!
    @IBOutlet weak var __email: UITextField!
    @IBOutlet weak var __password: UITextField!
    @IBOutlet weak var __confirmPassword: UITextField!
    @IBOutlet weak var __invalid_user_info_msg: UILabel!
    @IBOutlet weak var __incorrect_info_msg: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func nextBtnHandler(_ sender: Any) {
        if __check_user_info(name: __name.text!, birthday: __birthday.text!) {
            self.performSegue(withIdentifier: "toInputUserAccount", sender: self)
        }
        else {
            __invalid_user_info_msg.text = "이름, 생년월일 모두 입력해주세요."
        }
    }

    @IBAction func loginBtnHandler(_ sender: Any) {
        if __check_user_account(email: __email.text!, password: __password.text!, confirmPassword: __confirmPassword.text!) {
            self.performSegue(withIdentifier: "toTapBar", sender: self)
        }
        else {
            __incorrect_info_msg.text = "올바르지 않은 정보입니다."
        }
    }
}

func __check_user_info(name: String, birthday: String) -> Bool {
    if name.count > 0 && birthday.count > 0 {
        return true
    }
    return false
}

func __check_user_account(
    email: String, password: String, confirmPassword: String
) -> Bool {
    if password != confirmPassword {
        return false
    }
    else if email.count > 0 && password.count > 0 && confirmPassword.count > 0 {
        return true
    }
    return false
}
