
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
    func updateFavorite(itemIndex: Int)
}

protocol FLDataStore {
    var favoriteList: [MobilePhone] { get set }
}

class FavoriteListInteractor: FLInteractorBusinessLogic, FLDataStore {
    
    var presenter: FLPresentationLogic?
    var worker: FavoriteListWorker?
    var favoriteList: [MobilePhone] = []
    
    func getFavoriteList(list: [MobilePhone], sortType: SortType) {
        worker = FavoriteListWorker()
        if let favList = worker?.getFavoriteList(list: list, sortType: sortType) {
            favoriteList = favList
            self.presenter?.presentFavoriteList(list: favList)
        }
        else {
            favoriteList = list
            self.presenter?.presentFavoriteList(list: list)
        }
    }
    
    func updateFavorite(itemIndex: Int) {
        let mobile = favoriteList[itemIndex]
        NotificationCenter.default.post(name: .updateFavorite, object: nil, userInfo: ["id": mobile.id, "isFavorite": false])
    }
    
}
