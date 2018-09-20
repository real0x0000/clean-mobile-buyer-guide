//
//  MobilePhone.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import SwiftyJSON

struct MobilePhone {
    
    var thumbnailUrl: String?
    var name: String
    var rating: Double
    var id: Int
    var price: Double
    var desc: String
    var brand: String
    
}

extension MobilePhone {
    
    static func parseJSON(_ json: JSON) -> MobilePhone {
        let thumbnailUrl = json["thumbImageURL"].string
        let name = json["name"].stringValue
        let rating = json["rating"].doubleValue
        let id = json["id"].intValue
        let price = json["price"].doubleValue
        let desc = json["description"].stringValue
        let brand = json["brand"].stringValue
        return MobilePhone(thumbnailUrl: thumbnailUrl, name: name, rating: rating, id: id, price: price, desc: desc, brand: brand)
    }
    
}
