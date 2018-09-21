//
//  MainInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MainInteractorBusinessLogic {
    func getMobileList()
    func favoriteMobile(list: [MobilePhone], id: Int, isFavorite: Bool)
}

protocol MainInteractorDataStore {
    var sortType: SortType { get set }
}

class MainInteractor: MainInteractorBusinessLogic, MainInteractorDataStore {

    var sortType: SortType = .none
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    
    init(worker: MainWorker) {
        self.worker = worker
    }
    
    func getMobileList() {
        worker?.getMobileList(success: { (list) in
            self.presenter?.presentGetListResults(response: MainModel.Response(list: list, isError: false, message: nil))
        }, failure: { (errorMsg) in
            self.presenter?.presentGetListResults(response: MainModel.Response(list: [], isError: true, message: errorMsg))
        })
    }
    
    func favoriteMobile(list: [MobilePhone], id: Int, isFavorite: Bool) {
        if let updateList = worker?.favoriteMobile(list: list, id: id, isFavorite: isFavorite) {
            self.presenter?.presentUpdateList(list: updateList)
        }
        else {
            self.presenter?.presentUpdateList(list: list)
        }
    }
    
}
