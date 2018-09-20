//
//  MobileImageCell.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICHAK on 20/9/2561 BE.
//  Copyright © 2561 ANUWAT SITTICHAK. All rights reserved.
//

import SDWebImage
import UIKit

class MobileImageCell: UICollectionViewCell {
    
    @IBOutlet weak var mobileImageView: UIImageView!
    
    func apply(_ imageUrl: String) {
        if let url = URL(string: imageUrl) {
            mobileImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}

