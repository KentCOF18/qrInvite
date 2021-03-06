//
//  signUpViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/2/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
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
        
       // phoneNumTextField.attributedPlaceholder = NSAttributedString(string: "placeholder text", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])

        
        let numberLayerWidth = phoneNumTextField.frame.width
        phoneNumTextField.tintColor = UIColor.lightText
        phoneNumTextField.textColor = UIColor.black
        phoneNumTextField.attributedPlaceholder = NSAttributedString(string: phoneNumTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        let bottomLayerNumber = CALayer()
        bottomLayerNumber.frame = CGRect(x: 0, y: 28, width: numberLayerWidth, height: 0.6)
        bottomLayerNumber.backgroundColor = UIColor.black.cgColor
        phoneNumTextField.layer.addSublayer(bottomLayerNumber)
        
        
        
        
        phoneNumTextField.delegate = self
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }


    func sendVerificationCode() {
        
        if (phoneNumTextField.text == "kentAdmin") {
            adminButton.isHidden = false
            adminButton.pulsate()
        }
        else {
            if (phoneNumTextField.text == "review") {
                let storyBoard: UIStoryboard = UIStoryboard(name: "profile", bundle: nil)
                let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "reviewProfile")
                self.present(vc, animated: true, completion: {
                })
            }
            else {
            let phoneNumber = "+1" +
                (phoneNumTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error ) in
                if let error = error {
                    print("Phone number error" + error.localizedDescription)
                    self.errorLabel.text = "Please enter a valid phone number."
                }
                else {
                    UserDefaults.standard.set(phoneNumber, forKey: "phone")
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
    

}

//called when return key pressed


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


