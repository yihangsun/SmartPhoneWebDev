//
//  ModelPokemon.swift
//  PokemonApp
//
//  Created by Yihang Sun on 4/23/21.
//

import Foundation

class ModelPokemon {
    var name: String = ""
    var ability: String  = ""
    var height: Int = 0
    var weight: Int = 0
    var picURL: String = ""

    init(_ name : String, _ ability : String, _ height : Int, _ weight : Int, _ picURL : String) {
        self.name = name
        self.ability = ability
        self.height = height
        self.weight = weight
        self.picURL = picURL
    }
}
