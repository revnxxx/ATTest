//
//  UserTableViewController.swift
//  ATTest
//
//  Created by Revn Revn on 09.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    private var users = [UserDto]()
    private let NUMBER_OF_SECTION = 1
    private let CELL_IDENTIFIRE = "userCell"
    private let NOTIFICATION_NAME = "userUpdate"
    private let TITEL = "USERS VIEW"
    
    @IBOutlet var userTabelView: UITableView!
    
    private let dataManager = DataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = TITEL
        userTabelView.rowHeight = userTabelView.frame.size.height - 10        
         NotificationCenter.default.addObserver(self, selector: #selector(self.updateUserUi(_:)), name: NSNotification.Name(rawValue: NOTIFICATION_NAME), object: nil)
        dataManager.getUsers()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return NUMBER_OF_SECTION
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE, for: indexPath) as? UserTableViewCell {
            let data = users[indexPath.row]
            cell.updateUICell(userDto: data)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    @objc func updateUserUi(_ notification: NSNotification) {
        self.users = (notification.userInfo!["users"] as? [UserDto])!
        userTabelView.reloadData()
    }
}
