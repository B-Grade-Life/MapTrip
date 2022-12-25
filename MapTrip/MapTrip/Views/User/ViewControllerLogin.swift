//
//  ViewControllerLogin.swift
//  MapTrip
//
//  Created by david-laugh(Lee Gyu Hyuk) on 2022/12/24.
//

import UIKit


class ViewControllerLogin: UIViewController {
    @IBOutlet weak var __email: UITextField!
    @IBOutlet weak var __password: UITextField!
    @IBOutlet weak var __failed_login_msg: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnHandler(_ sender: Any) {
        if __login(email: __email.text!, password: __password.text!) {
            self.performSegue(withIdentifier: "toTapBar", sender: self)
        } else {
            __failed_login_msg.text = "잘못된 계정 또는 비밀번호"
        }
    }
}


func __login(email: String, password: String) -> Bool {
    if email.count > 0 && password.count > 0 {
        // Login API
        return true
    }
    return false
}
