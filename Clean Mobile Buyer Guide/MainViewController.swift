//
//  MainViewController.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {
    
    fileprivate let mobileVC = MobileListViewController()
    fileprivate let favoriteVC = FavoriteListViewController()
    
    @IBAction func sortList(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        let lowPriceAction = UIAlertAction(title: "Price low to high", style: .default, handler: { _ in
            
        })
        let highPriceAction = UIAlertAction(title: "Price high to low", style: .default, handler: { _ in
            
        })
        let ratingAction = UIAlertAction(title: "Rating", style: .default, handler: { _ in
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(lowPriceAction)
        alertController.addAction(highPriceAction)
        alertController.addAction(ratingAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = UIColor.white
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.lightGray
            newCell?.label.textColor = UIColor.black
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [mobileVC, favoriteVC]
    }
    
}
