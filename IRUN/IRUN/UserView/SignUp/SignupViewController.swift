//
//  SignupViewController.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 12/07/2021.
//

import UIKit
class SignupViewController: UIViewController {
    
    
    @IBOutlet var usernameEdit: UITextField!
    @IBOutlet var passwordEdit: UITextField!
    @IBOutlet var passwordconfirmEdit: UITextField!
    
    let userService: UserService = UserService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        
        var a = false
        var b = false
        
        if(usernameEdit.text == "" || passwordEdit.text == "" || passwordconfirmEdit.text == "") {
            let alertController = UIAlertController(title: "Attention", message: "Veuillez remplir tous les champs", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            a = true
        }
        
        if passwordEdit.text == passwordconfirmEdit.text {
            b = true
        } else {
            
            let alertController = UIAlertController(title: "Attention", message: "Les mots de passe sont différents", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        
        if a == true && b == true {
            
            guard let username = self.usernameEdit.text,
                  let password = self.passwordEdit.text
            else {
                return
            }
            
            let user = User(username: username, password: password)
            
            self.userService.newUser(user: user) { (success) in
                print("create account success  : \(success)")
                if success {
                    print("success create account will naviguate to Home")
                    let home = ListNearbyDevicesViewController()
                    self.navigationController?.pushViewController(home, animated: true)
                } else { self.showPopUpErrorAccount() }
            }
          
            
        }
        

    }
    
    private func showPopUpErrorAccount() {
        let alertController = UIAlertController(title: "Impossible de créer un compte", message: "Veuillez utiliser un autre identifiant", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

