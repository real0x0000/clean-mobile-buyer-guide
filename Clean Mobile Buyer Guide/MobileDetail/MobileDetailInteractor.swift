//
//  MobileDetailInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MDInteractorBusinessLogic {
    func getMobileImages(_ id: Int)
}

class MobileDetailInteractor: MDInteractorBusinessLogic {
    
    var presenter: MDPresentationLogic?
    var worker: MobileDetailWorker?

    func getMobileImages(_ id: Int) {
        worker = MobileDetailWorker()
        worker?.getMobileImages(id, success: { (urls) in
            self.presenter?.presentGetImagesResult(urls: urls, isError: false, errorMsg: nil)
        }, failure: { (errorMsg) in
            self.presenter?.presentGetImagesResult(urls: [], isError: true, errorMsg: errorMsg)
        })
    }

}
