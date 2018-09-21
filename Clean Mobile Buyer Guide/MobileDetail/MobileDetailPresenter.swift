//
//  MobileDetailPresenter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MDPresentationLogic {
    func presentMobileData(data: MobilePhone)
    func presentGetImagesResult(urls: [String], isError: Bool, errorMsg: String?)
}

class MobileDetailPresenter: MDPresentationLogic {
    
    weak var viewController: MDDisplayLogic?
    
    func presentMobileData(data: MobilePhone) {
        viewController?.presentMobileData(data: data)
    }
    
    func presentGetImagesResult(urls: [String], isError: Bool, errorMsg: String?) {
        if isError {
            viewController?.errorGetMobileImages(errorMsg: errorMsg)
        }
        else {
            viewController?.successGetMobileImages(imageUrls: urls)
        }
    }
    
}
