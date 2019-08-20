//
//  UIImage + Extencion.swift
//  TestApp
//
//  Created by Цындрин Антон on 19.08.2019.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public func imageFromImage( resizeTo:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(resizeTo, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: resizeTo.width, height: resizeTo.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
