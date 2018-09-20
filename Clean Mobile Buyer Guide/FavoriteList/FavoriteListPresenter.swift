//
//  FavoriteListPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol FLPresentationLogic {
    func presentFavoriteList(list: [MobilePhone])
}

class FavoriteListPresenter: FLPresentationLogic {
    
    weak var viewController: FLDisplayLogic?

    func presentFavoriteList(list: [MobilePhone]) {
        viewController?.presentFavoriteList(list: list)
    }
    
}
