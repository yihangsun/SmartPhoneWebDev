//
//  ModelFiveDaysForecast.swift
//  weatherApp
//
//  Created by Yihang Sun on 3/17/21.
//

import Foundation

class ModelFiveDaysForecast{
    var week : String = ""
    var weekHighTemps : Int = 0
    var weekLowTemps : Int = 0
    var dayIcons : Int = 0
    var nightIcons : Int = 0
    
    init(_ week : String, _ weekHighTemps : Int, _ weekLowTemps : Int, _ dayIcons : Int, _ nightIcons : Int) {
        
        self.week = getDayOfWeek(week)!
        self.weekHighTemps = weekHighTemps
        self.weekLowTemps = weekLowTemps
        self.dayIcons = dayIcons
        self.nightIcons = nightIcons
    }
    func getDayOfWeek(_ today:String) -> String? {
        let weekdayArr = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ'"
        
        guard let todayDate = formatter.date(from: today) else { return "" }
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekdayArr[weekDay - 1]
    }
}
