//
//  Cities.swift
//  PrayerTimes
//
//  Created by Safa on 2.12.2023.
//

import Foundation

struct Cities : Codable {
    let city : [City]
}


struct City : Codable, Identifiable, Hashable {
    var id : UUID?
    let name : String
}
