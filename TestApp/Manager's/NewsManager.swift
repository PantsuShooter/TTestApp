//
//  NewsManager.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/10/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import RealmSwift

class NewsManager {
    
    // MARK: - Variables
    public static let shared = NewsManager()
    private let realm = try! Realm()
    
    // MARK: - Helper's
    private func storeNews(news:NewsModel) {
        try! realm.write {
            realm.add(news)
        }
    }
    
    // MARK: - Public
    public func getNews() -> Results<NewsModel> {
        return realm.objects(NewsModel.self)
    }
    
    public func getSortedResult(string:String) ->  Results<NewsModel> {
        if string.isEmpty {
            return getNews()
        }
        return realm.objects(NewsModel.self).filter("title CONTAINS[c] '\(string)' OR descriptionText CONTAINS[c] '\(string)'")
    }
    
    public func requestLatestNews() {
        
        guard let jsonArray = RequestManager.shared.getJsonData() else {return}
        
        for object in jsonArray {
            
            let news = NewsModel()
            news.author = object["author"] as? String
            news.title = object["title"] as? String
            news.descriptionText = object["description"] as? String
            news.url = object["url"] as? String
            news.urlToImage = object["urlToImage"] as? String
            news.publishedAt = object["publishedAt"] as? String
            news.content = object["content"] as? String
            news.id = object["id"] as? String
            
            guard isExist(news: news) else {continue}
            storeNews(news: news)
        }
    }
    
    // MARK: - Private
    private func isExist(news:NewsModel) -> (Bool) {
        return realm.objects(NewsModel.self).filter("id  = '\(news.id!)'").isEmpty
    }
}
