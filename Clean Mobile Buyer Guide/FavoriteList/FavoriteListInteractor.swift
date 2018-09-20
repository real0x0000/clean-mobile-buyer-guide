
//
//  FavoriteListInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol FLInteractorBusinessLogic {
    func getFavoriteList(list: [MobilePhone], sortType: SortType)
}

protocol FLDataStore {
    var favoritePhone: MobilePhone? { get set }
}

class FavoriteListInteractor: FLInteractorBusinessLogic, FLDataStore {
    
    var presenter: FLPresentationLogic?
    var worker: FavoriteListWorker?
    var favoritePhone: MobilePhone?
    
    func getFavoriteList(list: [MobilePhone], sortType: SortType) {
        worker = FavoriteListWorker()
        if let favList = worker?.getFavoriteList(list: list, sortType: sortType) {
            self.presenter?.presentFavoriteList(list: favList)
        }
        else {
            self.presenter?.presentFavoriteList(list: list)
        }
    }
    
}
