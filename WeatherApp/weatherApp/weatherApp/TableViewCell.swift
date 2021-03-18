//
//  TableViewCell.swift
//  weatherApp
//
//  Created by Yihang Sun on 3/9/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblWeek: UILabel!
    @IBOutlet weak var lblWeekHigh: UILabel!
    @IBOutlet weak var lblWeekLow: UILabel!
    @IBOutlet weak var lblDayIcon: UIImageView!
    @IBOutlet weak var lblNightIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
