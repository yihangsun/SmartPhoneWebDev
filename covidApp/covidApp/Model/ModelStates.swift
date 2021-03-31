//
//  ModelStates.swift
//  covidApp
//
//  Created by Yihang Sun on 3/30/21.
//

import Foundation

class ModelStates{
    var state: String = ""
    var total: Int  = 0
    var pos: Int  = 0
    
    init(_ state : String, _ total : Int, _ pos : Int) {
        self.state = state
        self.total = total
        self.pos = pos
    }
}
