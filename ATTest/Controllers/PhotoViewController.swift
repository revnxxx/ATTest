//
//  PhotoViewController.swift
//  ATTest
//
//  Created by Revn Revn on 08.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    private let NOTIFICATION_NAME = "photoUpdate"
    private let TITEL = "PHOTO VIEW"
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    private let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = TITEL
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatePostUi(_:)), name: NSNotification.Name(rawValue: NOTIFICATION_NAME), object: nil)
        
        dataManager.getPhoto()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func updatePostUi(_ notification: NSNotification) {
        let data = notification.userInfo!["photo"] as? PhotoDto
        titelLabel.text = data?.title
        let urlImage = URL(string: (data?.url)!)
        let dataImage = try? Data(contentsOf: urlImage!)
        photoImage.image = UIImage(data: dataImage!)
    }
}
