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
}

protocol MLDataStore {
    var mobilePhone: MobilePhone? { get set }
}

class MobileListInteractor: MLInteractorBusinessLogic, MLDataStore {
    
    var presenter: MLPresentationLogic?
    var worker: MobileListWorker?
    var mobilePhone: MobilePhone?
        
    func sortList(list: [MobilePhone], sortType: SortType) {
        worker = MobileListWorker()
        if let sortList = worker?.sortList(list: list, sortType: sortType) {
            self.presenter?.presentSortList(list: sortList)
        }
        else {
            self.presenter?.presentSortList(list: list)
        }
    }
    
}
