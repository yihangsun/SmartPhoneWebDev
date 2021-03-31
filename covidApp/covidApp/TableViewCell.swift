//
//  TableViewCell.swift
//  covidApp
//
//  Created by Yihang Sun on 3/30/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblPos: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
