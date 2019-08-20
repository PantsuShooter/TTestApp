//
//  NewsModel.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/10/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import RealmSwift

class NewsModel: Object {
    
    @objc dynamic var author: String?
    @objc dynamic var title: String?
    @objc dynamic var descriptionText: String?
    @objc dynamic var url: String?
    @objc dynamic var urlToImage: String?
    @objc dynamic var publishedAt: String?
    @objc dynamic var content: String?
    @objc dynamic var id: String?

}
