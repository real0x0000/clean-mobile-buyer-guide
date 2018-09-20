//
//  MobileDetailViewController.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import UIKit

class MobileDetailViewController: UIViewController {
    
    fileprivate var mobile: MobilePhone!
    fileprivate var mobileImagesUrl: [String] = []
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
//        vm.rx_mobile
//            .filter { $0 != nil }
//            .map { $0! }
//            .subscribe(onNext: { [unowned self] in
//                self.mobile = $0
//                self.displayMobile()
//                self.vm.getMobileImages($0.id)
//            }).disposed(by: disposeBag)
//        vm.rx_mobileImagesUrl
//            .filter { $0.count != 0 }
//            .subscribe(onNext: { [unowned self] in
//                self.mobileImagesUrl = $0
//                self.imageCollectionView.reloadData()
//            }).disposed(by: disposeBag)
    }
    
    fileprivate func displayMobile() {
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
    
}

