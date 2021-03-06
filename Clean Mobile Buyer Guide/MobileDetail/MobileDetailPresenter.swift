//
//  MobileDetailPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MobileDetailPresenterInterface {
    func presentMobileData(data: MobilePhone)
    func presentGetImagesResult(response: MobileDetail.GetMobileImages.Response)
}

class MobileDetailPresenter: MobileDetailPresenterInterface {
    
    weak var viewController: MobileDetailViewControllerInterface?
    
    func presentMobileData(data: MobilePhone) {
        viewController?.presentMobileData(data: data)
    }
    
    func presentGetImagesResult(response: MobileDetail.GetMobileImages.Response) {
        let viewModel = MobileDetail.GetMobileImages.ViewModel(imageUrls: response.imageUrls, isError: response.isError, errorMsg: response.errorMsg)
        viewController?.presentGetMobileImages(viewModel: viewModel)
    }
    
}
