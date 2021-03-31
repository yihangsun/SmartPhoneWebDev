//
//  ViewController.swift
//  covidApp
//
//  Created by Yihang Sun on 3/30/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tblStates: UITableView!
    var statesData : [ModelStates] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblStates.delegate = self
        self.tblStates.dataSource = self
        
        DispatchQueue.main.async {
            SwiftSpinner.show("Getting COVID Information").addTapHandler({
              SwiftSpinner.hide()
            }, subtitle: "Tap to hide while connecting! This will affect only the current operation.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addStates()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell


        if self.statesData.count > 0  {
            cell.lblState?.text = "\(self.statesData[indexPath.row].state)"
            cell.lblTotal?.text = "Total: \(self.statesData[indexPath.row].total)"
            cell.lblPos?.text = "Pos: \(self.statesData[indexPath.row].pos)"
        }
        return cell
    }
}

