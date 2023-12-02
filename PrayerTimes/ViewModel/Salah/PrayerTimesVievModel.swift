//
//  PrayerTimesVievModel.swift
//  PrayerTimes
//
//  Created by Safa on 2.12.2023.
//

import Foundation


class PrayerTimesViewModel {
    
    
    func getCities (completition: @escaping (([City]?) -> Void)) {
        
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {

            guard let url = URL(fileURLWithPath: path) as? URL else {
                print("DEBUG: URL error")
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                print(ErrorType.invalidData.description)
                return
                
            }

            do {
                let result = try JSONDecoder().decode(Cities.self, from: data)
                completition(result.city)
            } catch  {
                print(ErrorType.invalidJSONParse.description)
            }
        }
            
            
            
            
            
    }
        
}
    
    
    
    

