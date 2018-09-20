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
    func presentSortList(list: [MobilePhone])
}

class MobileListViewController: UITableViewController, MLDisplayLogic {
    
    var itemInfo: IndicatorInfo = "View"
    var interactor: MLInteractorBusinessLogic?
    fileprivate var mobileList: [MobilePhone] = []
   
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
        let interactor = MobileListInteractor()
        let presenter = MobileListPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MobileCell", bundle: Bundle.main), forCellReuseIdentifier: "MobileCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func presentSortList(list: [MobilePhone]) {
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
    
    @objc fileprivate func favorite(_ sender: UIButton) {
        let row = sender.tag
        let mobile = mobileList[row]
        if !(mobile.isFavorite) {
            let id = mobile.id
            NotificationCenter.default.post(name: Notification.Name.updateFavorite, object: nil, userInfo: ["id": id, "isFavorite": true])
        }
    }
    
}

extension MobileListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
}
