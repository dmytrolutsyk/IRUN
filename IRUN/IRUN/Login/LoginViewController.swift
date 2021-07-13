//
//  LoginViewController.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 12/07/2021.
//

import UIKit
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    let loginService: LoginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case username:
            password.becomeFirstResponder()
        case password:
            self.view.endEditing(true)
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func login(_ sender: Any) {
        print("tapped")
        
        if(username.text == "" || password.text == "" ) {
            let alertController = UIAlertController(title: "Attention", message: "Veuillez remplir tous les champs", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            let user = User( email: "", password: password.text ?? "", type: "", username: username.text , phone: "", city: "" )
            
            self.loginService.login(user: user) { (success) in
                
            }
            
            let del = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + del) {
                
                if ERR == "Login OK"{
                    loginUser = self.username.text
                    let home = DevicesTableViewController()
                    self.navigationController?.pushViewController(home, animated: true)
                }
                else{
                    let alertController = UIAlertController(title: "Impossible de se conncter", message: "Veuillez vérifier vos identifiants", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    @IBAction func Signup(_ sender: UIButton) {
        print("taped")
        let signup = SignupViewController()
        self.navigationController?.pushViewController(signup, animated: true)
    }
}
