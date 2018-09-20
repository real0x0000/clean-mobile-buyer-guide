//
//  MobileListPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MLPresentationLogic {
    func presentGetListResults(response: MobileListModel.Response)
}

class MobileListPresenter: MLPresentationLogic {
    
    weak var viewController: MLDisplayLogic?
    
    func presentGetListResults(response: MobileListModel.Response) {
        if response.isError {
            viewController?.errorGetMobileList(errorMsg: response.message)
        }
        else {
            viewController?.successGetMobileList(list: response.list)
        }
    }
    
}
