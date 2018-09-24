//
//  MobileListPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MobileListPresentationInterface {
    func presentList(response: MobileListModel.GetMobileList.Response)
}

class MobileListPresenter: MobileListPresentationInterface {
    
    weak var viewController: MobileListViewControllerInterface?
    
    func presentList(response: MobileListModel.GetMobileList.Response) {
        viewController?.presentMobileList(viewModel: MobileListModel.GetMobileList.ViewModel(list: response.list))
    }
    
}
