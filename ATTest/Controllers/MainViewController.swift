//
//  MainViewController.swift
//  ATTest
//
//  Created by Revn Revn on 08.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    @IBOutlet var cardTabelView: UITableView!
    
    private let NUMBER_OF_SECTION = 1
    private let CELL_IDENTIFIRE = "cell"
    private let SEGUE_TO_POST = "post"
    private let SEGUE_TO_COMMENT = "comment"
    private let SEGUE_TO_USER = "user"
    private let SEGUE_TO_PHOTO = "photo"
    private let SEGUE_TO_TODOS = "todos"
    
    private let cardData = CardData.loadCardData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTabelView.delegate = self
        cardTabelView.dataSource = self
        let fullHiight = cardTabelView.frame.size.height
        let tabHeight = self.tabBarController?.tabBar.frame.size.height
        cardTabelView.rowHeight = ((fullHiight - tabHeight!) / 5) - 10
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return NUMBER_OF_SECTION
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cardData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE, for: indexPath) as? CardTableViewCell {
            let data = cardData[indexPath.row]
            cell.updateUICell(cardData: data)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
                    case 0:
                        self.performSegue(withIdentifier: SEGUE_TO_POST, sender: self)
                    break
                    case 1: self.performSegue(withIdentifier: SEGUE_TO_COMMENT, sender: self)
                    break
                    case 2: self.performSegue(withIdentifier: SEGUE_TO_USER, sender: self)
                    break
                    case 3: self.performSegue(withIdentifier: SEGUE_TO_PHOTO, sender: self)
                    break
                    case 4:
                    randomTaskForToDoBySegue()
                    break
                    default:
                        break
                    }
    }
    
    func randomTaskForToDoBySegue() {
        let randTask = arc4random_uniform(4)
        switch randTask{
        case 0:
            self.performSegue(withIdentifier: SEGUE_TO_POST, sender: self)
            break
        case 1: self.performSegue(withIdentifier: SEGUE_TO_COMMENT, sender: self)
            break
        case 2: self.performSegue(withIdentifier: SEGUE_TO_USER, sender: self)
            break
        case 3: self.performSegue(withIdentifier: SEGUE_TO_PHOTO, sender: self)
            break
        default:
            break
        }
    }
}
