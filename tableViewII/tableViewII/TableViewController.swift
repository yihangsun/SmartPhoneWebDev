//
//  TableViewController.swift
//  tableViewII
//
//  Created by Yihang Sun on 2/17/21.
//

import UIKit

class TableViewController: UITableViewController {

    let cities = ["Seattle", "Boston", "Miami", "Austin", "Georgia"]
    let temperatures = ["41", "26", "77", "29", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.lblCity.text = cities[indexPath.row]
        cell.lblTemperature.text = "\(temperatures[indexPath.row])°F"

        // Configure the cell...

        return cell
    }
}
