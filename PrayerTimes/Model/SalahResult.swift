//
//  SalahResult.swift
//  PrayerTimes
//
//  Created by Safa on 1.12.2023.
//

import Foundation

enum SalahResult {
    case success(_ salahs : [Salah])
    case failure(_ error : ErrorType)
}
