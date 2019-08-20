//
//  UserModel.swift
//  TestApp
//
//  Created by Цындрин Антон on 19.08.2019.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation

class  UserModel {
    
    let userImageUrl:String
    let userName:String
    
    init(userImageUrl:String, userName:String) {
        self.userImageUrl = userImageUrl
        self.userName     = userName
    }
    
}
