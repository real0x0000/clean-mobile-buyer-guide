//
//  MobileListModel.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

struct MobileListModel {
    
    struct GetMobileList {
        
        struct Request {}
        
        struct Response {
            var list: [MobilePhone]
        }
        
        struct ViewModel {
            var list: [MobilePhone]
        }
        
    }
    
}
