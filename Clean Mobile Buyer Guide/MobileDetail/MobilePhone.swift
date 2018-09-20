//
//  MobilePhone.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import SwiftyJSON

struct MobilePhone {
    
    let name: String
    let id: Int
    let desc: String
    let thumbnailUrl: String?
    let rating: Double
    let price: Double
    let brand: String
    var isFavorite: Bool
    
}

extension MobilePhone {
    
    static func parseJSON(_ json: JSON) -> MobilePhone {
        let name = json["name"].stringValue
        let id = json["id"].intValue
        let desc = json["description"].stringValue
        let thumbnailUrl = json["thumbImageUrl"].string
        let rating = json["rating"].doubleValue
        let price = json["price"].doubleValue
        let brand = json["brand"].stringValue
        return MobilePhone(name: name, id: id, desc: desc, thumbnailUrl: thumbnailUrl, rating: rating, price: price, brand: brand, isFavorite: false)
    }
    
}
