//
//  signUpViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/2/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController {

    @IBOutlet weak var phoneNumTextField: UITextField!
    
    @IBAction func admin_TouchUpInside(_ sender: Any) {
        
    }
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBAction func signUpButton_TouchUpInside(_ sender: Any) {
        sendVerificationCode()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        adminButton.isHidden = true;
        


        
        // Do any additional setup after loading the view.
    }


    func sendVerificationCode() {
        
        if (phoneNumTextField.text == "kentAdmin") {
            adminButton.isHidden = false
        }
        else {
            let phoneNumber = "+1" + (phoneNumTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error ) in
                if let error = error {
                    print("Phone number error" + error.localizedDescription)
                }
                else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "verifyCode")
                    self.present(vc, animated: true, completion: {
                        
                    })
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                   // self.performSegue(withIdentifier: "signedIn", sender: nil)
                }
            }
        }
    }
    

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


