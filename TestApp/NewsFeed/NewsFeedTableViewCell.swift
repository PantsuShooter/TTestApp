//
//  NewsFeedTableViewCell.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/10/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class NewsFeedTableViewCell: UITableViewCell{
    
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!
    @IBOutlet private weak var newsAuthorLabel: UILabel!
    
    public func setuCell(news:NewsModel) {
        if let author = news.author {
            newsAuthorLabel.text = author
        }
        if let title = news.title {
            newsTitleLabel.text = title
        }
        if let description = news.descriptionText {
            newsDescriptionLabel.text = description
        }
        if let date = news.publishedAt {
            newsDateLabel.text = date
        }
        if let author = news.author {
            newsAuthorLabel.text = author
        }
        if let imgURl = news.urlToImage {
            newsImageView.sd_setImage(with: URL(string: imgURl), placeholderImage: UIImage(named: "orlando-pirates-news-placeholder"))
        }
    }
}
