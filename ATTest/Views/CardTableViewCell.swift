//
//  CardTableViewCell.swift
//  ATTest
//
//  Created by Revn Revn on 08.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!

    func updateUICell(cardData: CardData){
        iconImage.image = UIImage(named: cardData.titel)
        titelLabel.text = cardData.titel.capitalized
    }
}
