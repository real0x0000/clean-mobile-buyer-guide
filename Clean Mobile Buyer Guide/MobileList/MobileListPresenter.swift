//
//  MobileListPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MLPresentationLogic {
    func presentList(list: [MobilePhone])
}

class MobileListPresenter: MLPresentationLogic {
    
    weak var viewController: MLDisplayLogic?
    
    func presentList(list: [MobilePhone]) {
        viewController?.presentList(list: list)
    }
    
}
