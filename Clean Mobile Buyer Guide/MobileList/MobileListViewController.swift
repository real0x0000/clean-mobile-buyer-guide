//
//  MobileListViewController.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol MLDisplayLogic: class
{
    func presentList(list: [MobilePhone])
}

class MobileListViewController: UITableViewController, MLDisplayLogic {
    
    var interactor: MLInteractorBusinessLogic?
    var router: (NSObjectProtocol & MobileRoutingLogic & MobileDataPassing)?
    fileprivate var itemInfo: IndicatorInfo = "View"
    fileprivate var isFavorite = false
    fileprivate var mobileList: [MobilePhone] = []
   
    init(itemInfo: IndicatorInfo, isFavorite: Bool) {
        self.itemInfo = itemInfo
        self.isFavorite = isFavorite
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
        let interactor = MobileListInteractor(worker: MobileListWorker())
        let presenter = MobileListPresenter()
        let router = MobileListRouter()
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

    func presentList(list: [MobilePhone]) {
        mobileList = list
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MobileCell", for: indexPath) as? MobileCell else { return MobileCell() }
        let mobile = mobileList[indexPath.row]
        cell.apply(mobile)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(MobileListViewController.favorite(_:)), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToDetail(itemIndex: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isFavorite
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            alertRemoveFavorite(indexPath)
        }
    }

    fileprivate func alertRemoveFavorite(_ indexPath: IndexPath) {
        let mobile = mobileList[indexPath.row]
        let alertController = UIAlertController(title: "Are you sure you want to delete \(mobile.name) from favorite?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.interactor?.updateFavorite(itemIndex: indexPath.row, isFavorite: false)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc fileprivate func favorite(_ sender: UIButton) {
        let row = sender.tag
        interactor?.updateFavorite(itemIndex: row, isFavorite: true)
    }
    
}

extension MobileListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
}
