//
//  LoginVC.swift
//  First-Chat
//
//  Created by Neven on 19/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailField: TextFieldLooks!
    
    @IBOutlet weak var passwordField: TextFieldLooks!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text, email.count > 0 && password.count > 0 {
            AuthService.instance.login(email: email, password: password, onComplete: { (errMsg, data) in
                if let errMsg = errMsg {
                self.presentErrorAlert(title: "Error Authencation", msg: errMsg, actionTitle: "Ok")
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else {
            presentErrorAlert(title: "Email and Password Required", msg: "Both email and password should be filled.", actionTitle: "Ok")
        }
    }
    
    func presentErrorAlert(title: String ,msg: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
