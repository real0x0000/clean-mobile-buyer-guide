//
//  MainViewController.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol MainDisplayLogic: class
{
    func successGetMobileList(list: [MobilePhone])
    func errorGetMobileList(errorMsg: String?)
    func updateFavoriteList(list: [MobilePhone])
}

class MainViewController: ButtonBarPagerTabStripViewController, MainDisplayLogic {
    
    fileprivate let mobileVC = MobileListViewController(itemInfo: "All")
    fileprivate let favoriteVC = FavoriteListViewController(itemInfo: "Favorite")
    fileprivate var interactor: MainInteractorBusinessLogic?
    fileprivate var mobileList: [MobilePhone] = []
    fileprivate var sortType: SortType = .none
    
    @IBAction func sortList(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        let lowPriceAction = UIAlertAction(title: "Price low to high", style: .default, handler: { _ in
            self.sortType = .lowPrice
            self.updateList(list: self.mobileList, sortType: .lowPrice)
        })
        let highPriceAction = UIAlertAction(title: "Price high to low", style: .default, handler: { _ in
            self.sortType = .highPrice
            self.updateList(list: self.mobileList, sortType: .highPrice)
        })
        let ratingAction = UIAlertAction(title: "Rating", style: .default, handler: { _ in
            self.sortType = .rating
            self.updateList(list: self.mobileList, sortType: .rating)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(lowPriceAction)
        alertController.addAction(highPriceAction)
        alertController.addAction(ratingAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.updateList(_:)), name: .updateFavorite, object: nil)
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
        interactor?.getMobileList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [mobileVC, favoriteVC]
    }
    
    @objc fileprivate func updateList(_ notification: Notification) {
        if let id = notification.userInfo?["id"] as? Int, let isFavorite = notification.userInfo?["isFavorite"] as? Bool {
            interactor?.favoriteMobile(list: mobileList, id: id, isFavorite: isFavorite)
        }
    }
    
    func successGetMobileList(list: [MobilePhone]) {
        updateList(list: list, sortType: .none)
    }
    
    func errorGetMobileList(errorMsg: String?) {
        let alertController = UIAlertController(title: nil, message: errorMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateFavoriteList(list: [MobilePhone]) {
        updateList(list: list, sortType: self.sortType)
    }
    
    fileprivate func updateList(list: [MobilePhone], sortType: SortType) {
        mobileList = list
        mobileVC.interactor?.sortList(list: list, sortType: sortType)
        favoriteVC.interactor?.getFavoriteList(list: list, sortType: sortType)
    }
    
}
