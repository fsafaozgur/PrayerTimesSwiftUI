//
//  SalahModel.swift
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
    let time: String
    let salah: String
    
    
    private enum CodingKeys : String, CodingKey {
        case time = "saat"
        case salah = "vakit"
    }
}

