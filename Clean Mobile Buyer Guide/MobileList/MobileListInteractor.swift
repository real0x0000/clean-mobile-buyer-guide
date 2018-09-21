//
//  MobileListInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol MLInteractorBusinessLogic {
    func getList(list: [MobilePhone], sortType: SortType)
    func getFavoriteList(list: [MobilePhone], sortType: SortType)
    func updateFavorite(itemIndex: Int, isFavorite: Bool)
}

protocol MLDataStore {
    var mobileList: [MobilePhone] { get set }
}

class MobileListInteractor: MLInteractorBusinessLogic, MLDataStore {
    
    var presenter: MLPresentationLogic?
    var worker: MobileListWorker? = MobileListWorker()
    var mobileList: [MobilePhone] = []
    
    func getList(list: [MobilePhone], sortType: SortType) {
        mobileList = list
        if let sortList = worker?.sortList(list: list, sortType: sortType) {
            self.presenter?.presentList(list: sortList)
        }
        else {
            self.presenter?.presentList(list: list)
        }
    }
    
    func getFavoriteList(list: [MobilePhone], sortType: SortType) {
        mobileList = list
        if let favList = worker?.getFavoriteList(list: list, sortType: sortType) {
            presenter?.presentList(list: favList)
        }
        else {
            presenter?.presentList(list: list)
        }
    }
    
    func updateFavorite(itemIndex: Int, isFavorite: Bool) {
        let mobile = mobileList[itemIndex]
        if isFavorite {
            if !(mobile.isFavorite) {
                NotificationCenter.default.post(name: Notification.Name.updateFavorite, object: nil, userInfo: ["id": mobile.id, "isFavorite": true])
            }
        }
        else {
            NotificationCenter.default.post(name: Notification.Name.updateFavorite, object: nil, userInfo: ["id": mobile.id, "isFavorite": false])
        }
    }
    
}
