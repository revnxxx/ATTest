//
//  CardData.swift
//  ATTest
//
//  Created by Revn Revn on 08.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import Foundation

class CardData {
    private var _tite: String
    
    init(titel: String) {
        _tite = titel
    }
    
    var titel: String {
        return _tite
    }
    
    public static func loadCardData() -> [CardData] {
        var datas = [CardData]()
        let data1 = CardData(titel: "posts")
        datas.append(data1)
        let data2 = CardData(titel: "comments")
        datas.append(data2)
        let data3 = CardData(titel: "users")
        datas.append(data3)
        let data4 = CardData(titel: "photos")
        datas.append(data4)
        let data5 = CardData(titel: "todos")
        datas.append(data5)
        
        return datas
    }
    
}
