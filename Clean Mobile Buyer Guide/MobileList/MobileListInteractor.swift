//
//  MobileListInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol MLInteractorBusinessLogic {
    func getMobileList(sortType: SortType)
}

protocol MLInteractorDataStore {
    //
}

class MobileListInteractor: MLInteractorBusinessLogic, MLInteractorDataStore {
    
    var presenter: MLPresentationLogic?
    var worker: MobileListWorker?
    
    func getMobileList(sortType: SortType) {
        worker = MobileListWorker()
        worker?.getMobileList(sortType: sortType, success: { (list) in
            self.presenter?.presentGetListResults(response: MobileListModel.Response(list: list, isError: false, message: nil))
        }, failure: { (errorMsg) in
            self.presenter?.presentGetListResults(response: MobileListModel.Response(list: [], isError: true, message: errorMsg))
        })
    }
    
}
