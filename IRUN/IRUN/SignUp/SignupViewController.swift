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
    
    let signupService: SignupService = SignupService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            self.signupService.signup(user: user) { (success) in
                print("\(success)")
            }
            
            let refreshAlert = UIAlertController(title: "Confirmation", message: "Le compte \(username) a bien été crée", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
                }
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
    }
    
}






