//
//  MobileListRouter.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol MobileRoutingLogic {
    func routeToDetail(itemIndex: Int)
}

protocol MobileDataPassing {
    var dataStore: MobileListDataStore? { get set }
}

class MobileListRouter: NSObject, MobileRoutingLogic, MobileDataPassing {
    
    weak var viewController: MobileListViewController?
    var dataStore: MobileListDataStore?
    
    func routeToDetail(itemIndex: Int) {
        guard let vc = UIStoryboard(name: "MobileDetail", bundle: nil).instantiateViewController(withIdentifier: "MobileDetail") as? MobileDetailViewController else { return }
        if let ds = dataStore {
            vc.interactor?.mobileData = ds.mobileList[itemIndex]
        }
        viewController?.show(vc, sender: nil)
    }
    
}

