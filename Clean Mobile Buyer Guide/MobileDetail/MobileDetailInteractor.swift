//
//  MobileDetailInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MDInteractorBusinessLogic {
    func getMobileImages()
    func getMobileData()
}

protocol MDDataStore {
    var mobileData: MobilePhone? { get set }
}

class MobileDetailInteractor: MDInteractorBusinessLogic, MDDataStore {
    
    var presenter: MDPresentationLogic?
    var worker: MobileDetailWorker?
    var mobileData: MobilePhone?
    
    func getMobileData() {
        if let data = mobileData {
            self.presenter?.presentMobileData(data: data)
        }
    }
    
    func getMobileImages() {
        worker = MobileDetailWorker()
        if let id = mobileData?.id {
            worker?.getMobileImages(id, success: { (urls) in
                self.presenter?.presentGetImagesResult(urls: urls, isError: false, errorMsg: nil)
            }, failure: { (errorMsg) in
                self.presenter?.presentGetImagesResult(urls: [], isError: true, errorMsg: errorMsg)
            })
        }
    }

}
