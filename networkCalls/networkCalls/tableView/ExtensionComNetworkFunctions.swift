//
//  ExtensionComNetworkFunctions.swift
//  networkCalls
//
//  Created by Yihang Sun on 3/3/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

extension TableViewController {
        func getUrl() -> String{
        var url = apiUrl
        url.append(apikey)
        return url
    }
    
    func addCommodity() {
        let url = getUrl()
        getCommodities(url: url)
            .done { (commodities) in
             self.commodityArr = [Commodity]()
                
                for commodity in commodities {
                    self.commodityArr.append(commodity)
                }
                self.tblCommodities.reloadData()
            }
            .catch { (error) in
                print("Error in getting all the commodities")
            }
    }
    
    func getCommodities(url : String) -> Promise<[Commodity]> {
        return Promise<[Commodity]> { seal -> Void in
            AF.request(url).responseJSON { (response) in
                if response.error == nil {
                    guard let data = response.data else { return seal.fulfill( [Commodity]() ) }
                    guard let commodities = JSON(data).array else { return seal.fulfill( [Commodity]() ) }
                    var arr = [Commodity]()

                    for eachOne in commodities {
                        let name = eachOne["name"].stringValue
                        let price = eachOne["price"].floatValue
                        
                        let comm = Commodity(name: name, price: price)
                        comm.name = name
                        comm.price = price
                        arr.append(comm)
                    }
                    seal.fulfill(arr)
                } else {
                    seal.reject(response.error!)
                }
            }
        }
    }
}
