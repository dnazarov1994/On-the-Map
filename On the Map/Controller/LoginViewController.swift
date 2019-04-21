//
//  ViewController.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/17/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            let safari = SFSafariViewController.init(url:url)
            present(safari, animated: true, completion: nil)
        }
    }
    
    @IBAction func logInButton(_ sender: Any) {
        let username = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let login = LoginRequest(password: password, username: username)
        let user = UdacityRequest(udacity:  login)
                
        UdacityClient.taskForPOSTRequest(url: UdacityClient.Endpoints.login.url, responseType: LoginResponse.self, body: user) { (value, error) in
            if let error = error {
                self.showLoginFailure(message: error.localizedDescription)
            }
            if value != nil {
                UdacityClient.loginData = value
                self.performSegue(withIdentifier: "showMapTabView", sender: nil)
            }
        }
        
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

