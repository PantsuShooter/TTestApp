//
//  RequestManager.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/10/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import FBSDKShareKit
import FBSDKLoginKit

class RequestManager: NSObject {
    
    // MARK: - Variables
    public static let shared = RequestManager()
    private let session = URLSession(configuration: .default)
    
    // MARK: - Public
    public func getJsonData() -> [[String:Any]]? {
        guard let fileURL = Bundle.main.url(forResource: "newsData", withExtension: "json") else {
            debugPrint("\(self)| fileURL is nil")
            return nil
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            debugPrint("\(self)| data is nil")
            return nil
        }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
            debugPrint("\(self)| json is nil")
            return nil
        }
        return json
    }
    
    public func getUresInfo( onSuccess: @escaping (_ user:UserModel) -> ()) {
        GraphRequest(graphPath: "me", parameters:["fields":"name,picture.width(500).height(500)"]).start {
            (connection, result, error) in
            
            guard let sResult = result as? [String:Any], let name = sResult["name"] as? String, let picture = sResult["picture"] as? [String:Any], let data = picture["data"] as? [String: Any], let url = data["url"] as? String else {return}
            
            let user = UserModel(userImageUrl: url, userName: name)
            onSuccess(user)
        }
    }
}

