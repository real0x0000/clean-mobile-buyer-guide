//
//  FavoriteListWorker.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import Foundation

class FavoriteListWorker {
    
    func getFavoriteList(list: [MobilePhone], sortType: SortType) -> [MobilePhone] {
        let favList = list.filter { $0.isFavorite }
        let sList = sortList(list: favList, sortType: sortType)
        return sList
    }
    
    func sortList(list: [MobilePhone], sortType: SortType) -> [MobilePhone] {
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
