//
//  TableViewController.swift
//  networkCalls
//
//  Created by Yihang Sun on 3/2/21.
//


import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class TableViewController: UITableViewController {
    
    @IBOutlet var tblCommodities: UITableView!
    
    var commodityArr : [Commodity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addCommodity()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commodityArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        cell.lblName.text = commodityArr[indexPath.row].name
        cell.lblPrice.text = String(commodityArr[indexPath.row].price)
        return cell
    }
    
//    func getUrl() -> String{
//        var url = apiUrl
//        url.append(apikey)
//        return url
//    }
    
//    func getData() {
//        let url = getUrl()
//
//
////        AF.request(url).responseJSON { (response) in
////            if response.error == nil {
////                guard let data = response.data else { return }
////                guard let commodities = JSON(data).array else { return }
////                if commodities.count == 0 { return }
////                if let json = try? JSON(data : data) {
////                    for eachOne in json.arrayValue {
////                        print(eachOne["name"].stringValue)
////                        self.nameArr.append(eachOne["name"].stringValue)
////                        print(eachOne["price"].stringValue)
////                        self.priceArr.append(eachOne["price"].stringValue)
////                    }
////                }
////
////                self.tblCommodities.reloadData()
////            }
////        }
//    }
}

