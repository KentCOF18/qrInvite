//
//  profileViewController.swift
//  qrInvite
//
//  Created by Nick potts on 3/9/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class profileViewController: UIViewController {

    @IBOutlet weak var adminButton: UIButton!
    @IBAction func adminButton_TouchUpInside(_ sender: Any) {
    }
    @IBOutlet weak var myProfileText: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminButton.backgroundColor = UIColor.lightGray
        adminButton.layer.cornerRadius = 8.0
        getQRImage()
        
        // Do any additional setup after loading the view.
    }
    var databaseHandle: DatabaseHandle?
   
    func getQRImage() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        databaseHandle = ref.child("users").child(uid!).child("url").observe(.childAdded)
        { (snapshot) in
            let qrCode = snapshot.value as? String
            
            if let actualCode = qrCode {
                let imageURL = URL(string: actualCode)
                var image: UIImage?
                if let url = imageURL {
                    DispatchQueue.global(qos: .userInitiated).async {
                        let imageData = NSData(contentsOf: url)
                        //All UI operations has to run on main thread.
                        DispatchQueue.main.async {
                            if imageData != nil {
                                image = UIImage(data: imageData! as Data)!
                                UserDefaults.standard.set(imageData, forKey: "profileQRCode")
                                self.qrImage.image = image
                                self.qrImage.sizeToFit()
                            }
                            
                        }
                    }
                }
            }
            
        }
    }


}
