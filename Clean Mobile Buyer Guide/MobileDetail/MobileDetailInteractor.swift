//
//  MobileDetailInteractor.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

protocol MobileDetailInteractorInterface {
    func getMobileImages(request: MobileDetail.GetMobileImages.Request)
    func getMobileData()
     var mobileData: MobilePhone? { get set }
}

class MobileDetailInteractor: MobileDetailInteractorInterface {
    
    var presenter: MobileDetailPresenterInterface?
    var worker: MobileDetailWorker?
    var mobileData: MobilePhone?
    
    func getMobileData() {
        if let data = mobileData {
            presenter?.presentMobileData(data: data)
        }
    }
    
    func getMobileImages(request: MobileDetail.GetMobileImages.Request) {
        worker = MobileDetailWorker()
        if let id = mobileData?.id {
            worker?.getMobileImages(id, success: { [weak self] (urls) in
                self?.presenter?.presentGetImagesResult(response: MobileDetail.GetMobileImages.Response(imageUrls: urls, isError: false, errorMsg: nil))
            }, failure: { [weak self] (errorMsg) in
                self?.presenter?.presentGetImagesResult(response: MobileDetail.GetMobileImages.Response(imageUrls: [], isError: true, errorMsg: errorMsg))
            })
        }
    }

}
