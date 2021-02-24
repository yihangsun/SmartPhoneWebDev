//
//  TableViewController.swift
//  News
//
//  Created by Yihang Sun on 2/23/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class TableViewController: UITableViewController {

    @IBOutlet var tblNews: UITableView!
    var newsArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        cell.lblTitle.text = newsArr[indexPath.row]
        return cell
    }
    
    func getUrl() -> String{
        var url = apiUrl
        url.append("top-headlines?country=us&category=business&apiKey=")
        url.append(apikey)
        return url
    }
    
    func getData() {
        let url = getUrl()

        AF.request(url).responseJSON { (response) in
            if response.error == nil {
                guard let data = response.data else { return }
                
                //self.newsArr = [newsData]()
                if let json = try? JSON(data : data) {
                    for article in json["articles"].arrayValue {
                        print(article["title"].stringValue)
                        self.newsArr.append(article["title"].stringValue)
                    }
                }

                self.tblNews.reloadData()
            }
        }
    }
}
