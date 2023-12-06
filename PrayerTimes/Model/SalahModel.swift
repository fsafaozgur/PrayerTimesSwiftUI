//
//  TimeModel.swift
//  PrayerTimes
//
//  Created by Safa on 30.11.2023.
//

import Foundation


struct SalahObject : Codable {
    let success: Bool
    let result: [Salah]
}

struct Salah : Codable, Identifiable, Hashable {
    
    var id : UUID?
    let saat: String
    let vakit: String
}

 /*enum CodingKeys: String, CodingKey {
    case saat, vakit
}*/


struct TimeFormat {
    static func fetchTime() -> String {
   
        let calendar = Calendar.current
        let now = Date()
        let nowDay = calendar.component(.day, from: now)
        let nowMonth = calendar.component(.month, from: now)
        let nowYear = calendar.component(.year, from: now)
        
        
        
        
        let someTime = DateComponents(calendar: calendar,year: nowYear, month: nowMonth, day: nowDay, hour: 15, minute: 27)
        let someDate = calendar.date(from: someTime)
        guard let someDate = someDate else {return ""}
        let difference = calendar.dateComponents([.hour, .minute, .second], from: now, to: someDate)
        
        if let hours = difference.hour,
           let minutes = difference.minute,
           let seconds = difference.minute {
            
            let lastingTime = "\(hours) hour \(minutes) minutes \(seconds) seconds"
            return lastingTime
        }
        
        return ""
        
        
        
        
        /*
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcTimeZoneStr = formatter.string(from: date)
        return utcTimeZoneStr*/
        
    }
}
