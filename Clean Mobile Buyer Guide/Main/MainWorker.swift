//
//  MainWorker.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

class MainWorker {
    
    func getMobileList(sortType: SortType, success: @escaping(([MobilePhone]) -> ()), failure: @escaping((String) -> ())) {
        ConnectionController.share.makeRequest(Properties.Service.SERVICE_URL, onCompletion: { (result) in
            if let json = result {
                let list = json.map { (_, js) in MobilePhone.parseJSON(js) }
                success(list)
            }
            else {
                failure(Properties.Message.MESSAGE_ERROR_RESPONSE)
            }
        }, onError: { (errorMsg) in
            failure(errorMsg)
        })
    }
    
}
