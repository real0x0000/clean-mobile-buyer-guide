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
    func presentMobileData(data: MobilePhone)
    func presentGetMobileImages(viewModel: MobileDetail.GetMobileImages.ViewModel)
}

final class MobileDetailViewController: UIViewController, MDDisplayLogic {
 
    var router: (NSObjectProtocol & MobileDetailPassing)?
    var interactor: MDInteractorBusinessLogic?
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
        interactor?.getMobileData()
        interactor?.getMobileImages(request: MobileDetail.GetMobileImages.Request())
    }

    func presentMobileData(data: MobilePhone) {
        navigationItem.title = data.name
        priceLabel.text = "Price: \(data.price)"
        ratingLabel.text = "Rating: \(data.rating)"
        descLabel.text = data.desc
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
    
    func presentGetMobileImages(viewModel: MobileDetail.GetMobileImages.ViewModel) {
        switch viewModel.isError {
        case true:
            let alertController = UIAlertController(title: nil, message: viewModel.errorMsg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        case false:
            mobileImagesUrl = viewModel.imageUrls
            imageCollectionView.reloadData()
        }
    }
    
}

