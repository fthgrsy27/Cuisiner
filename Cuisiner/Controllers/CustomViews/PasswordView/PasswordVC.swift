//
//  PasswordView.swift
//  Cuisiner
//
//  Created by Fatih Gursoy on 27.06.2022.
//

import UIKit

class PasswordVC: UIViewController {
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    private var authManager = AuthManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func OKTapped(_ sender: Any) {
        
        if oldPassword.text != "" && newPassword.text != "" {
            
            guard let oldPassword = oldPassword.text,
                  let newPassword = newPassword.text
            else { return }
            
            authManager.updatePassword(currentPassword: oldPassword, newPassword: newPassword) { success in
                
                if success {
                    self.presentAlert(title: "Password", message: "Password Updated", completion: { _ in
                        self.dismiss(animated: true)
                    })
                    
                } else {
                    if let error = self.authManager.errorMessage {
                        self.presentAlert(title: "Error", message: error, completion: nil)
                    }
                }   
            }
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
}





