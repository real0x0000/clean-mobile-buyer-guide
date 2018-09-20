//
//  MobileDetailViewController.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

protocol MDDisplayLogic: class
{
    func successGetMobileImages(imageUrls: [String])
    func errorGetMobileImages(errorMsg: String?)
}

class MobileDetailViewController: UIViewController, MDDisplayLogic {
 
    var router: (NSObjectProtocol & MobileDetailRoutingLogic & MobileDetailPassing)?
    fileprivate var interactor: MDInteractorBusinessLogic?
    fileprivate var mobileImagesUrl: [String] = []
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let interactor = MobileDetailInteractor()
        let presenter = MobileDetailPresenter()
        let router = MobileDetailRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        if let mobileData = router?.dataStore?.mobileData {
            interactor?.getMobileImages(mobileData.id)
            displayMobile(mobileData)
        }
    }
    
    fileprivate func displayMobile(_ mobile: MobilePhone) {
        navigationItem.title = mobile.name
        priceLabel.text = "Price: \(mobile.price)"
        ratingLabel.text = "Rating: \(mobile.rating)"
        descLabel.text = mobile.desc
    }

}

extension MobileDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    fileprivate func initCollectionView() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mobileImagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MobileImageCell", for: indexPath) as? MobileImageCell else { return UICollectionViewCell() }
        let url = mobileImagesUrl[indexPath.row]
        cell.apply(url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenHeight = UIScreen.main.bounds.height
        let cellHeight = screenHeight * 0.35
        let cellWidth = (screenHeight * 4) / 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func successGetMobileImages(imageUrls: [String]) {
        mobileImagesUrl = imageUrls
        imageCollectionView.reloadData()
    }
    
    func errorGetMobileImages(errorMsg: String?) {
        let alertController = UIAlertController(title: nil, message: errorMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

