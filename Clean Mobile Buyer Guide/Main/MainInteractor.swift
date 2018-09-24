//
//  MainInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MainInteractorBusinessLogic {
    func getMobileList(request: MainModel.GetMobile.Request)
    func favoriteMobile(id: Int, isFavorite: Bool)
}

protocol MainInteractorDataStore {
    var mobileList: [MobilePhone] { get set }
    var sortType: SortType { get set }
}

class MainInteractor: MainInteractorBusinessLogic, MainInteractorDataStore {

    var sortType: SortType = .none
    var mobileList: [MobilePhone] = []
    var presenter: MainPresentationLogic?
    var worker: MainWorker?

    init(worker: MainWorker) {
        self.worker = worker
    }
    
    func getMobileList(request: MainModel.GetMobile.Request) {
        worker?.getMobileList(success: { [weak self] (list) in
            self?.mobileList = list
            self?.presenter?.presentGetListResults(response: MainModel.GetMobile.Response(list: list, isError: false, message: nil))
        }, failure: { (errorMsg) in
            self.presenter?.presentGetListResults(response: MainModel.GetMobile.Response(list: [], isError: true, message: errorMsg))
        })
    }
    
    func favoriteMobile(id: Int, isFavorite: Bool) {
        if let updateList = worker?.favoriteMobile(list: mobileList, id: id, isFavorite: isFavorite) {
            mobileList = updateList
        }
        presenter?.presentUpdateList()
    }
    
}
