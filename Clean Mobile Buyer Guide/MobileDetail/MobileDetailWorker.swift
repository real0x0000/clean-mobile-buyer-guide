//
//  MobileDetailWorker.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

class MobileDetailWorker {

    func getMobileImages(_ id: Int, success: @escaping(([String]) -> ()), failure: @escaping((String) -> ())) {
        ConnectionController.share.makeRequest("\(Properties.Service.SERVICE_URL)/\(id)/images/", onCompletion: { (result) in
            if let json = result {
                let imagesUrl = json.map { (_, js) in self.fillHttp(js["url"].stringValue) }
                success(imagesUrl)
            }
            else {
                failure(Properties.Message.MESSAGE_ERROR_RESPONSE)
            }
        }, onError: { (errorMsg) in
            failure(errorMsg)
        })
    }
    
    fileprivate func fillHttp(_ url: String) -> String {
        if url.range(of: "http") == nil {
            return "http://" + url
        }
        return url
    }
    
}
