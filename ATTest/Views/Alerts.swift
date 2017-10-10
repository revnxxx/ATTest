//
//  Alerts.swift
//  ATTest
//
//  Created by Revn Revn on 10.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit

class Alert {
    
    func createAlert (controller: UIViewController, titel: String, messege: String) {
        let alertController = UIAlertController(title: titel, message: messege, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
