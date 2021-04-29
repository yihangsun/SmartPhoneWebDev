//
//  ViewController.swift
//  weatherApp
//
//  Created by Yihang Sun on 3/9/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblhigh: UILabel!
    @IBOutlet weak var lbllow: UILabel!
    @IBOutlet weak var lblCurNightIcon: UIImageView!
    
    @IBOutlet weak var tblWeeks: UITableView!

    var weeksData : [ModelFiveDaysForecast] = []
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        self.tblWeeks.delegate = self
        self.tblWeeks.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            getTempData(getTempURL())
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weeksData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell


        if self.weeksData.count > 0  {
            cell.lblWeek?.text = "\(self.weeksData[indexPath.row].week)"
            cell.lblWeekHigh?.text = "\(self.weeksData[indexPath.row].weekHighTemps)"
            cell.lblWeekLow?.text = "\(self.weeksData[indexPath.row].weekLowTemps)"
            cell.lblDayIcon?.image = UIImage(named: "\(self.weeksData[indexPath.row].dayIcons)-s")
            cell.lblNightIcon?.image = UIImage(named: "\(self.weeksData[indexPath.row].nightIcons)-s")
        }
        return cell
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currLocation = locations.last{
            let lat = currLocation.coordinate.latitude
            let lng = currLocation.coordinate.longitude
            
            let urlLocation = getLocationURL(lat, lng)
            self.getLocationData(urlLocation).done { (city, key) in
                self.lblCity.text = city
                
                let urlTemp = self.getTempURL()
                self.getCurTemp(urlTemp).done { (max, min) in
                    self.lblhigh.text = String(max) + "℉"
                    self.lbllow.text = String(min) + "℉"
                }
                .catch { error in
                    print("Error in getting temperature Data \(error.localizedDescription)")
                }
            }
            .catch { error in
                print("Error in getting city Data \(error.localizedDescription)")
            }
            
            
            let urlCurTemp = getCurTempURL()
            self.getCurTempData(urlCurTemp).done { (weather, temp, icon) in
                self.lblCondition.text = weather
                self.lblTemp.text = String(temp) + "℉"
                self.lblCurNightIcon.image = UIImage(named: "\(icon)-s")
            }
            .catch { error in
                print("Error in getting city Data \(error.localizedDescription)")
            }
        }
    }
}

extension ViewController {
    func getLocationURL(_ lat : CLLocationDegrees , _ lng : CLLocationDegrees) -> String {
        var url = locaURL
        url.append("\(apiKey)&q=\(lat)%2C%20\(lng)")
        return url
    }
    
    func getTempURL() -> String {
        var url = tempURL
        url.append("/\(key)?apikey=\(apiKey)")
        return url
    }
    
    func getCurTempURL() -> String {
        var url = curTempURL
        url.append(apiKey)
        return url
    }
}

extension ViewController {
    func getTempData(_ url : String) {
        AF.request(url).responseJSON { response in
            if response.error == nil {
                guard response.data != nil else { return }
                let locationJSON : JSON = JSON(response.data as Any)
                    for forecast in locationJSON["DailyForecasts"].arrayValue {
                        let day = forecast["Date"].stringValue
                        let high = forecast["Temperature"]["Maximum"]["Value"].intValue
                        let low = forecast["Temperature"]["Minimum"]["Value"].intValue
                        let dayIcon = forecast["Day"]["Icon"].intValue
                        let nightIcon = forecast["Night"]["Icon"].intValue
                        
                        let daysModel : ModelFiveDaysForecast = ModelFiveDaysForecast(day, high, low, dayIcon, nightIcon)
                        self.weeksData.append(daysModel)
                    }
                self.tblWeeks.reloadData()
            }
        }
    }
    
    func getLocationData(_ url : String) -> Promise<(String, String)> {
        return Promise< (String, String) > { seal -> Void in
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let locationJSON : JSON = JSON(response.data as Any)
                let city = locationJSON["ParentCity"]["LocalizedName"].stringValue
                let key = locationJSON["Key"].stringValue
                seal.fulfill((city, key))
            }
        }
    }
    
    func getCurTempData(_ url : String) -> Promise<(String, Int, Int)> {
        return Promise< (String, Int, Int) > { seal -> Void in
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let locationJSON : JSON = JSON(response.data as Any)
                let weather = locationJSON[0]["WeatherText"].stringValue
                let temp = locationJSON[0]["Temperature"]["Imperial"]["Value"].intValue
                let night = locationJSON[0]["WeatherIcon"].intValue
                seal.fulfill((weather, temp, night))
            }
        }
    }
    
    func getCurTemp(_ url : String) -> Promise<(Int, Int)> {
        return Promise< (Int, Int) > { seal -> Void in
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let locationJSON : JSON = JSON(response.data as Any)
                let max = locationJSON["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                let min = locationJSON["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                seal.fulfill((max, min))
            }
        }
    }
}
