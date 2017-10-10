//
//  UserTableViewCell.swift
//  ATTest
//
//  Created by Revn Revn on 09.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var suiteLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var webSiteLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var catchPhraseLabel: UILabel!
    @IBOutlet weak var bsLabel: UILabel!
    
    func updateUICell(userDto: UserDto) {
        nameLabel.text = userDto.name
        userNameLabel.text = userDto.username
        emailLabel.text = userDto.email
        streetLabel.text = userDto.street
        suiteLabel.text = userDto.suite
        cityLabel.text = userDto.city
        zipCodeLabel.text = userDto.zipcode
        latLabel.text = userDto.lat
        lngLabel.text = userDto.lng
        phoneLabel.text = userDto.phone
        webSiteLabel.text = userDto.website
        companyNameLabel.text = userDto.companyName
        catchPhraseLabel.text = userDto.catchPhrase
        bsLabel.text = userDto.bs
    }
}
