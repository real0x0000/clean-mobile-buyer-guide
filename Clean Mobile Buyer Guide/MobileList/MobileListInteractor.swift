//
//  MobileListInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol MobileListInteractorInterface {
    func getList(list: [MobilePhone], sortType: SortType)
    func getFavoriteList(list: [MobilePhone], sortType: SortType)
    func updateFavorite(itemIndex: Int, isFavorite: Bool)
}

protocol MobileListDataStore {
    var mobileList: [MobilePhone] { get set }
}

class MobileListInteractor: MobileListInteractorInterface, MobileListDataStore {
    
    var presenter: MobileListPresentationInterface?
    var worker: MobileListWorker?
    var mobileList: [MobilePhone] = []
    
    init(worker: MobileListWorker) {
        self.worker = worker
    }
    
    func getList(list: [MobilePhone], sortType: SortType) {
        if let sortList = worker?.sortList(list: list, sortType: sortType) {
            mobileList = sortList
            presenter?.presentList(response: MobileListModel.GetMobileList.Response(list: sortList))
        }
        else {
            mobileList = list
            presenter?.presentList(response: MobileListModel.GetMobileList.Response(list: list))
        }
    }
    
    func getFavoriteList(list: [MobilePhone], sortType: SortType) {
        if let favList = worker?.getFavoriteList(list: list, sortType: sortType) {
            mobileList = favList
            presenter?.presentList(response: MobileListModel.GetMobileList.Response(list: favList))
        }
        else {
            mobileList = list
            presenter?.presentList(response: MobileListModel.GetMobileList.Response(list: list))
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
