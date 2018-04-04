//
//  checkedInListViewController.swift
//  qrInvite
//
//  Created by Nick potts on 4/1/18.
//  Copyright © 2018 Nexus. All rights reserved.
//

import UIKit

class checkedInListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    var list = ["Why", "Wont", "this", "work"]
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(guest.count)
        return guest.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
        //print(list[indexPath.row])
        cell.textLabel?.text = guest[indexPath.row]
        print(guest[indexPath.row])
        return(cell)
    }



}
