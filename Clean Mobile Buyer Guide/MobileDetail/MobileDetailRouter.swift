//
//  MobileDetailRouter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MobileDetailPassing {
    var dataStore: MDDataStore? { get set }
}

class MobileDetailRouter: NSObject, MobileDetailPassing {
    
    weak var viewController: MobileDetailViewController?
    var dataStore: MDDataStore?
    
}
