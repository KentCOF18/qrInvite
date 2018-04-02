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

        //guestList.delegate = self
        //guestList.dataSource = self
        // Do any additional setup after loading the view.
    }
    let list = ["Milk", "Honey", "Tea"]
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
        cell.textLabel?.text = list[indexPath.row]
        return(cell)
    }



}
