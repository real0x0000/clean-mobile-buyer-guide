//
//  MobileListWorker.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

class MobileListWorker {
    
    func getMobileList(sortType: SortType, success: @escaping(([MobilePhone]) -> ()), failure: @escaping((String) -> ())) {
        ConnectionController.share.makeRequest(Properties.Service.SERVICE_URL, onCompletion: { (result) in
            if let json = result {
                let list = json.map { (_, js) in MobilePhone.parseJSON(js) }
                let sList = self.sortList(sortType: sortType, list: list)
                success(sList)
            }
            else {
                failure(Properties.Message.MESSAGE_ERROR_RESPONSE)
            }
        }, onError: { (errorMsg) in
            failure(errorMsg)
        })
    }
    
    func sortList(sortType: SortType, list: [MobilePhone]) -> [MobilePhone] {
        var sortList: [MobilePhone] = []
        switch sortType {
        case .lowPrice:
            sortList = list.sorted(by: { $0.price < $1.price })
        case .highPrice:
            sortList = list.sorted(by: { $0.price > $1.price })
        case .rating:
            sortList = list.sorted(by: { $0.rating > $1.rating })
        case .none:
            sortList = list
        }
        return sortList
    }

}
