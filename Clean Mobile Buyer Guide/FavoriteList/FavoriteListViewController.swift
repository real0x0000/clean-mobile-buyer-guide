//
//  FavoriteListViewController.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol FLDisplayLogic: class
{
    func presentFavoriteList(list: [MobilePhone])
}

class FavoriteListViewController: UITableViewController, FLDisplayLogic {
    
    var itemInfo: IndicatorInfo = "View"
    var interactor: FLInteractorBusinessLogic?
    var router: (NSObjectProtocol & FavoriteRoutingLogic & FavoriteDataPassing)?
    fileprivate var favoriteList: [MobilePhone] = []
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
        setup()
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
        let interactor = FavoriteListInteractor()
        let presenter = FavoriteListPresenter()
        let router = FavoriteListRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MobileCell", bundle: Bundle.main), forCellReuseIdentifier: "MobileCell")
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func presentFavoriteList(list: [MobilePhone]) {
        favoriteList = list
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MobileCell", for: indexPath) as? MobileCell else { return MobileCell() }
        cell.favoriteButton.isHidden = true
        let mobile = favoriteList[indexPath.row]
        cell.apply(mobile)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mobile = favoriteList[indexPath.row]
        router?.dataStore?.favoritePhone = mobile
        router?.routeToDetail()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            alertRemoveFavorite(indexPath)
        }
    }
    
    fileprivate func alertRemoveFavorite(_ indexPath: IndexPath) {
        let mobile = favoriteList[indexPath.row]
        let alertController = UIAlertController(title: "Are you sure you want to delete \(mobile.name) from favorite?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
           NotificationCenter.default.post(name: .updateFavorite, object: nil, userInfo: ["id": mobile.id, "isFavorite": false])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension FavoriteListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
}
