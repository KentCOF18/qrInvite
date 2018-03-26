//
//  verifyViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/5/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class verifyViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func verifyButton_TouchUpInside(_ sender: Any) {
        let code = codeTextField.text
        verifyCode(code: code!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        verifyButton.center.x = self.view.frame.width + 300
        verifyButton.isHidden = false
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            
            self.verifyButton.center.x = self.view.frame.width / 2
            
        }), completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyButton.isHidden = true
        self.hideKeyboardWhenTappedAround()
        verifyButton.layer.cornerRadius = 8.0
        verifyButton.backgroundColor = UIColor.lightGray
        
    }

    func verifyCode (code: String) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: code)
        Auth.auth().signIn(with: credential) { (user: User?,error ) in
            if error != nil {
                self.errorLabel.text = "Please enter the verification code."
            }
            else {
            var ref: DatabaseReference
            ref = Database.database().reference()
            print("The user is signed in and authenticated")
            let uid = user?.uid
            let phone = UserDefaults.standard.string(forKey: "phoneNumber")
            ref.child("users").child(uid!).setValue(["username": phone])
            let sb: UIStoryboard = UIStoryboard(name: "profile", bundle: nil)
            let vc: UIViewController = sb.instantiateInitialViewController()!
            self.present(vc, animated: true, completion: {
                
            })
            self.storeQRCode(phone: phone!)
            }
        }
       
    }
    func storeQRCode(phone: String) {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid!).child("url")
        let textMessage = nameTextField.text
        let urlTextMessage = textMessage?.replacingOccurrences(of: " ", with: "%20")
        let sms = ("SMSTO:\(phone):\(urlTextMessage!)")
        
        let phoneURL = ("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=\(sms)")
        userRef.setValue(["smsURL": phoneURL])
    }
}
