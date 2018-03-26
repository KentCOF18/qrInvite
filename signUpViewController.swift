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
        
        signInButton.center.x = self.view.frame.width + 300
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.signInButton.center.x = self.view.frame.width / 2
            
        }), completion: nil)
        
        self.hideKeyboardWhenTappedAround()
        
        signInButton.backgroundColor = UIColor.lightGray
        signInButton.layer.cornerRadius = 8.0
        
        adminButton.backgroundColor = UIColor.lightGray
        adminButton.layer.cornerRadius = 8.0
        adminButton.isHidden = true
        // Do any additional setup after loading the view.
    }


    func sendVerificationCode() {
        
        if (phoneNumTextField.text == "kentAdmin") {
            adminButton.isHidden = false
            adminButton.pulsate()
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

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 4.0
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
}


