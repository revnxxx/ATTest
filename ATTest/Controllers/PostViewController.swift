//
//  PostViewController.swift
//  ATTest
//
//  Created by Revn Revn on 08.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit
import Validator

class PostViewController: UIViewController, UITextFieldDelegate {

    private let NOTIFICATION_NAME = "postUpdate"
    private let TITEL = "POST VIEW"
    private let ALERT_TITEL = "Ошибка"
    private let ALERT_POST_ID_MUST_NOT_NULL = "Введите номер поста"
    private let MAX_POST_ID = 100
    
    @IBOutlet weak var postTitelLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var postIdEnter: UITextField!
    
    private let dataManager = DataManager()
    private let validator = ValidateController()
    private let alertController = Alert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postIdEnter.delegate = self
        self.navigationItem.title = TITEL
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatePostUi(_:)), name: NSNotification.Name(rawValue: NOTIFICATION_NAME), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
            self.view.frame.origin.y = 0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func sendPostRequest(_ sender: UIButton) {
        if postIdEnter.text == nil || postIdEnter.text == "" {
            alertController.createAlert(controller: self, titel: ALERT_TITEL, messege: ALERT_POST_ID_MUST_NOT_NULL)
        } else {
            let postData = validator.check(userInputData: postIdEnter.text!, maxInputId: MAX_POST_ID)
            if postData.error == nil {
            dataManager.getPost(postId: postData.id!)
            } else {
                alertController.createAlert(controller: self, titel: ALERT_TITEL, messege: (postData.error?.message)!)
            }
        }
    }
    
    @objc func updatePostUi(_ notification: NSNotification) {
        let data = notification.userInfo!["post"] as? PostDto
        postTitelLabel.text = data?.titel
        postBodyLabel.text = data?.body
    }
}
