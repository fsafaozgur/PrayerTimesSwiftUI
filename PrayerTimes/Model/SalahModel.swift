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
   
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcTimeZoneStr = formatter.string(from: date)
        return utcTimeZoneStr
        
    }
}
