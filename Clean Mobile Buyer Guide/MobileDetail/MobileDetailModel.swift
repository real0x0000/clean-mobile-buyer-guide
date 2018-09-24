//
//  MobileDetailModel.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

struct MobileDetail {
    
    struct GetMobileImages {
        
        struct Request {
            
        }
        
        struct Response {
            var imageUrls: [String]
            var isError: Bool
            var errorMsg: String?
        }
        
        struct ViewModel {
            var imageUrls: [String]
            var isError: Bool
            var errorMsg: String?
        }
        
    }
    
}

