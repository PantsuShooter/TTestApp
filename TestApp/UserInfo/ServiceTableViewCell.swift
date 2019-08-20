//
//  ServiceTableViewCell.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/11/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import UIKit

class ServiceTableViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var serviceImageView: UIImageView!
    
    public func setImage(image:UIImage) {
        serviceImageView.image = image
    }
    
}
