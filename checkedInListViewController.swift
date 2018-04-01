//
//  checkedInListViewController.swift
//  qrInvite
//
//  Created by Nick potts on 4/1/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit

class checkedInListViewController: UITableViewController {

    @IBOutlet var guestList: UITableView! {
        didSet {
            guestList.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        guestList.delegate = self
        guestList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("Number of sections")
        return 1
    }
    
    var i = 1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("With i")
        return i
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        print("Contains name")
        var name: String
        i = i + 1
        name = adminViewController().returnGuest()
        cell.textLabel?.text = name
        
        return cell
    }



}
