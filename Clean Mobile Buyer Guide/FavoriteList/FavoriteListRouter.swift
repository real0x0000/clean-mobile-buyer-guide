//
//  FavoriteListRouter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol FavoriteRoutingLogic {
    func routeToDetail()
}

protocol FavoriteDataPassing {
    var dataStore: FLDataStore? { get set }
}

class FavoriteListRouter: NSObject, FavoriteRoutingLogic, FavoriteDataPassing {
    
    weak var viewController: FavoriteListViewController?
    var dataStore: FLDataStore?
    
    func routeToDetail() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MOBILE_DETAIL") as? MobileDetailViewController else { return }
        var detailDataStore = vc.router!.dataStore!
        passData(source: dataStore!, destination: &detailDataStore)
        viewController?.show(vc, sender: nil)
    }
    
    func passData(source: FLDataStore, destination: inout MDDataStore) {
        destination.mobileData = source.favoritePhone
    }
    
}
