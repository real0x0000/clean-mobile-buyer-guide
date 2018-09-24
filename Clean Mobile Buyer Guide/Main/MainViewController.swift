//
//  MainViewController.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import NVActivityIndicatorView
import UIKit
import XLPagerTabStrip

protocol MainViewControllerInterface: class
{
    func presentGetMobileList(viewModel: MainModel.GetMobile.ViewModel)
    func updateList()
}

class MainViewController: ButtonBarPagerTabStripViewController, MainViewControllerInterface {
    
    fileprivate let mobileVC = MobileListViewController(itemInfo: "All", isFavorite: false)
    fileprivate let favoriteVC = MobileListViewController(itemInfo: "Favorite", isFavorite: true)
    var interactor: MainInteractorInterface?
    
    @IBAction func sortList(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        let lowPriceAction = UIAlertAction(title: "Price low to high", style: .default, handler: { [weak self] _ in
            self?.interactor?.sortType = .lowPrice
            self?.updateList()
        })
        let highPriceAction = UIAlertAction(title: "Price high to low", style: .default, handler: { [weak self] _ in
            self?.interactor?.sortType = .highPrice
            self?.updateList()
        })
        let ratingAction = UIAlertAction(title: "Rating", style: .default, handler: { [weak self] _ in
            self?.interactor?.sortType = .rating
            self?.updateList()
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
        let interactor = MainInteractor(worker: MainWorker())
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
        interactor?.getMobileList(request: MainModel.GetMobile.Request())
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [mobileVC, favoriteVC]
    }
    
    @objc func updateList(_ notification: Notification) {
        if let id = notification.userInfo?["id"] as? Int, let isFavorite = notification.userInfo?["isFavorite"] as? Bool {
            interactor?.favoriteMobile(id: id, isFavorite: isFavorite)
        }
    }
    
    func presentGetMobileList(viewModel: MainModel.GetMobile.ViewModel) {
        switch viewModel.isError {
        case true:
            let alertController = UIAlertController(title: nil, message: viewModel.message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        case false:
            updateList()
        }
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    func updateList() {
        mobileVC.interactor?.getList(list: interactor?.mobileList ?? [], sortType: interactor?.sortType ?? .none)
        favoriteVC.interactor?.getFavoriteList(list: interactor?.mobileList ?? [], sortType: interactor?.sortType ?? .none)
    }
    
}
