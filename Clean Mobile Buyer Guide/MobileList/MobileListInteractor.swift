//
//  MobileListInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol MLInteractorBusinessLogic {
    func sortList(list: [MobilePhone], sortType: SortType)
    func updateFavorite(itemIndex: Int)
}

protocol MLDataStore {
    var mobileList: [MobilePhone] { get set }
}

class MobileListInteractor: MLInteractorBusinessLogic, MLDataStore {
    
    var presenter: MLPresentationLogic?
    var worker: MobileListWorker?
    var mobileList: [MobilePhone] = []
    
    func sortList(list: [MobilePhone], sortType: SortType) {
        worker = MobileListWorker()
        if let sortList = worker?.sortList(list: list, sortType: sortType) {
            mobileList = sortList
            self.presenter?.presentSortList(list: sortList)
        }
        else {
            mobileList = list
            self.presenter?.presentSortList(list: list)
        }
    }
    
    func updateFavorite(itemIndex: Int) {
        let mobile = mobileList[itemIndex]
        if !(mobile.isFavorite) {
            NotificationCenter.default.post(name: Notification.Name.updateFavorite, object: nil, userInfo: ["id": mobile.id, "isFavorite": true])
        }
    }
    
}
