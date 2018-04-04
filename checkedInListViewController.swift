//
//  checkedInListViewController.swift
//  qrInvite
//
//  Created by Nick potts on 4/1/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit
import MessageUI

class checkedInListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {

    @IBOutlet var guestList: UITableView! {
        didSet {
            guestList.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var guest = [String]()
    //var list = ["Why", "Wont", "this", "work"]
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print(guest.count)
        return guest.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
        //print(list[indexPath.row])
        cell.textLabel?.text = guest[indexPath.row]
        print(guest[indexPath.row])
        return(cell)
    }
    
    func sendCountMessage(total: [String]) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "\(total) people have signed in";
        messageVC.recipients = ["+16147257253"]
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
            break;
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
            break;
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
            break;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! adminViewController
        destVC.guest = Array(Set(guest))
       // print(guest.count)
        destVC.count = guest.count
    }



}
