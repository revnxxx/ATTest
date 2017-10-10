//
//  CommentViewController.swift
//  ATTest
//
//  Created by Revn Revn on 08.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITextFieldDelegate {

    private let NOTIFICATION_NAME = "commentUpdate"
    private let TITEL = "COMMENT VIEW"
    private let ALERT_TITEL = "Ошибка"
    private let ALERT_COMMENT_ID_MUST_NOT_NULL = "Введите номер комментария"
    private let MAX_COMMENT_ID = 500
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var commentIdLabel: UITextField!
    
    private let dataManager = DataManager()
    private let validator = ValidateController()
    private let alertController = Alert()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentIdLabel.delegate = self
        self.navigationItem.title = TITEL
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateCommentUi(_:)), name: NSNotification.Name(rawValue: NOTIFICATION_NAME), object: nil)
        
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
    
    @IBAction func sendCommentRequest(_ sender: UIButton) {
        if commentIdLabel.text == nil || commentIdLabel.text == "" {
             alertController.createAlert(controller: self, titel: ALERT_TITEL, messege: ALERT_COMMENT_ID_MUST_NOT_NULL)
        } else {
            let commentData = validator.check(userInputData: commentIdLabel.text!, maxInputId: MAX_COMMENT_ID)
            if commentData.error == nil {
            dataManager.getComment(commentId: commentData.id!)
            } else {
                alertController.createAlert(controller: self, titel: ALERT_TITEL, messege: (commentData.error?.message)!)
            }
        }
    }
    
    @objc func updateCommentUi(_ notification: NSNotification) {
        let data = notification.userInfo!["comment"] as? CommentDto
        emailLabel.text = "EMAIL: " + (data?.email)!
        nameLabel.text = data?.name
        bodyLabel.text = data?.body
    }
}
