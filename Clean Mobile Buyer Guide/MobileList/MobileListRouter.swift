//
//  MobileListRouter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol MobileRoutingLogic {
    func routeToDetail()
}

protocol MobileDataPassing {
    var dataStore: MLDataStore? { get set }
}

class MobileListRouter: NSObject, MobileRoutingLogic, MobileDataPassing {
    
    weak var viewController: MobileListViewController?
    var dataStore: MLDataStore?
    
    func routeToDetail() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MOBILE_DETAIL") as? MobileDetailViewController else { return }
        var detailDataStore = vc.router!.dataStore!
        passData(source: dataStore!, destination: &detailDataStore)
        viewController?.show(vc, sender: nil)
    }
    
    func passData(source: MLDataStore, destination: inout MDDataStore) {
        destination.mobileData = source.mobilePhone
    }
    
}

