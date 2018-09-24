//
//  MainPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MainPresentationLogic {
    func presentGetListResults(response: MainModel.GetMobile.Response)
    func presentUpdateList()
}

class MainPresenter: MainPresentationLogic {
    
    weak var viewController: MainDisplayLogic?
    
    func presentGetListResults(response: MainModel.GetMobile.Response) {
        if response.isError {
            viewController?.errorGetMobileList(errorMsg: response.message)
        }
        else {
            viewController?.successGetMobileList()
//            viewController?.successGetMobileList(list: response.list)
        }
    }
    
    func presentUpdateList() {
        viewController?.updateFavoriteList()
    }
    
}

