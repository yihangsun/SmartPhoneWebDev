//
//  ModelUser.swift
//  SpotifyApp
//
//  Created by Yihang Sun on 4/22/21.
//

import Foundation

class ModelUser{
    var userName: String = ""
    var password: String  = ""
    
    init(_ userName : String, _ password : String) {
        self.userName = userName
        self.password = password
    }
}
