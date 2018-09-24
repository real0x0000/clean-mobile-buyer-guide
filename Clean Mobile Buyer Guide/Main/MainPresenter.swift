//
//  MainPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MainPresenterInterface {
    func presentGetListResults(response: MainModel.GetMobile.Response)
    func presentUpdateList()
}

class MainPresenter: MainPresenterInterface {
    
    weak var viewController: MainViewControllerInterface?
    
    func presentGetListResults(response: MainModel.GetMobile.Response) {
        viewController?.presentGetMobileList(viewModel: MainModel.GetMobile.ViewModel(isError: response.isError, message: response.message))
    }
    
    func presentUpdateList() {
        viewController?.updateList()
    }
    
}

