//
//  TableViewCell.swift
//  PokemonApp
//
//  Created by Yihang Sun on 4/23/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var buttonPressed : (() -> ()) = {}
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblPokemon: UILabel!
    @IBOutlet weak var butView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func GetPokemon(_ sender: Any){
        buttonPressed()
    }
    
}
