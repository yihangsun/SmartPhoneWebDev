//
//  ExtensionViewController.swift
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

extension ViewController {
    
    func getStateURL() -> String {
        return apiUrl
    }
    
    func getStatesData(_ url : String) -> Promise<[ModelStates]> {
        return Promise<[ModelStates]> { seal -> Void in
            AF.request(url).responseJSON { (response) in
                if response.error == nil {
                    guard let data = response.data else { return seal.fulfill( [ModelStates]() ) }
                    guard let states = JSON(data).array else { return seal.fulfill( [ModelStates]() ) }
                    var arr = [ModelStates]()
                    for eachOne in states {
                        let state = eachOne["state"].stringValue
                        let total = eachOne["total"].intValue
                        let pos = eachOne["positive"].intValue
                        let info = ModelStates(state, total, pos)
                        info.state = state
                        info.total = total
                        info.pos = pos
                        arr.append(info)
                    }
                    seal.fulfill(arr)
                } else {
                    seal.reject(response.error!)
                }
            }
        }
    }
    
    func addStates() {
        let url = getStateURL()
        getStatesData(url)
            .done { (states) in
                self.statesData = [ModelStates]()
                for state in states {
                    self.statesData.append(state)
                }
                self.tblStates.reloadData()
            }
            .catch { (error) in
                print("Error in getting all the States' Covid Information")
            }
    }
}
