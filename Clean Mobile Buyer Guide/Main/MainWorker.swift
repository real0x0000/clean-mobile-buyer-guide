//
//  MainWorker.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

class MainWorker {
    
    func getMobileList(success: @escaping(([MobilePhone]) -> ()), failure: @escaping((String) -> ())) {
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
    
    func favoriteMobile(list: [MobilePhone], id: Int, isFavorite: Bool) -> [MobilePhone] {
        var updateList: [MobilePhone] = list
        if let index = updateList.index(where: { $0.id == id }) {
            updateList[index].isFavorite = isFavorite
        }
        return updateList
    }
    
}
