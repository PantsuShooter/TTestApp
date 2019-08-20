//
//  UDManager.swift
//  TestApp
//
//  Created by Цындрин Антон on 19.08.2019.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation

class UDManager {
    
    // MARK: - Variables
    public static let shared = UDManager()
    
    private struct UDKey {
        static let User = "user"
        
        static let UserName = "userName"
        static let UserImgUrl = "userImgUrl"
    }
    
    // MARK: - Public
    public func storUser(userModel:UserModel) {
        let user = [UDKey.UserName:userModel.userName, UDKey.UserImgUrl:userModel.userImageUrl]
        UserDefaults.standard.set(user, forKey: UDKey.User)
    }
    
    public func getUser() ->UserModel? {

        guard let user = UserDefaults.standard.value(forKey: UDKey.User) as? [String:Any], let name = user[UDKey.UserName] as? String, let url = user[UDKey.UserImgUrl] as? String else {
            return nil
        }
        return UserModel(userImageUrl: url, userName: name)
    }
    
    public func removeUser() {
        UserDefaults.standard.removeObject(forKey: UDKey.User)
    }
}
