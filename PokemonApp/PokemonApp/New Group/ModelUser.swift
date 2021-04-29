//
//  ModelUser.swift
//  PokemonApp
//
//  Created by Yihang Sun on 4/23/21.
//

import Foundation

class ModelUser {
    var userName: String = ""
    var password: String  = ""
    var pokemon: String = ""

    init(_ userName : String, _ password : String, _ pokemon : String) {
        self.userName = userName
        self.password = password
        self.pokemon = pokemon
    }
}

