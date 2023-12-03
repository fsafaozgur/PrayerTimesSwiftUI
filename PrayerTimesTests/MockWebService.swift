//
//  MockWebService.swift
//  PrayerTimesTests
//
//  Created by Safa on 3.12.2023.
//

import Foundation
@testable import PrayerTimes

class MockWebService : HttpService, Mockable {
    
    func fetchDatas<T : Codable>(request req: URLRequest, type: T.Type, completition: @escaping (T?, ErrorType?) -> Void){

        loadFromJSON(filename: "Salahs", type: T.self) { (salahs, error) in
            completition(salahs, error)
        }
        
    }
    
    
}
