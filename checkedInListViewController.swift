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
    /*
    var guestListA: [String] = []
    override func viewDidAppear(_ animated: Bool) {
        var list = adminViewController().returnGuest()
        var i = 0
        let max = list.count
        while(i < max) {
            guestListA.append(list[i])
            i = i + 1
        }
    }
    */
    var list = ["Why", "Wont", "this", "work"]
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(list.count)
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
        print(list[indexPath.row])
        cell.textLabel?.text = list[indexPath.row]
        return(cell)
    }



}
