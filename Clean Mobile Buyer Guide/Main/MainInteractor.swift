//
//  MainInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MainInteractorBusinessLogic {
    func getMobileList(sortType: SortType)
}

class MainInteractor: MainInteractorBusinessLogic {
    
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    
    func getMobileList(sortType: SortType) {
        worker = MainWorker()
        worker?.getMobileList(sortType: sortType, success: { (list) in
            self.presenter?.presentGetListResults(response: MainModel.Response(list: list, isError: false, message: nil))
        }, failure: { (errorMsg) in
            self.presenter?.presentGetListResults(response: MainModel.Response(list: [], isError: true, message: errorMsg))
        })
    }
    
}
