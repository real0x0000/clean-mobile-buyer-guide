//
//  MobileListModel.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

struct MobileListModel {
    
    struct Response {
        var list: [MobilePhone]
        var isError: Bool
        var message: String?
    }
    
}
