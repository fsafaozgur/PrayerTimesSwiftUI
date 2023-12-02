//
//  SalahsViewModel.swift
//  PrayerTimes
//
//  Created by Safa on 1.12.2023.
//

import Foundation



class SalahsViewModel {
    
    
    func fetchTimes(_ city: String, completition: @escaping (SalahResult?) -> Void) {
        
        let city = trToEng(string: city)
        
        
        let headers = [
          "content-type": "application/json",
          "authorization": "apikey 2Wyw6ntUnM0ljtfOkuEAuX:7rekZl5MYoDe2h6fnawju4"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.collectapi.com/pray/all?data.city=\(city)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        WebService().fetchDatas(request: request as URLRequest, type:SalahObject.self) { data, error in
            
            if let error = error {
                completition(.failure(error))
            }
            
            if let data = data {
                completition(.success(data.result))
            }
                                
        }
            
    }
    
    
    func trToEng (string : String) -> String {
            let string = string.lowercased()
                .replacingOccurrences(of: "ı", with: "i")
                .replacingOccurrences(of: "ğ", with: "g")
                .replacingOccurrences(of: "ç", with: "c")
                .replacingOccurrences(of: "ş", with: "s")
                .replacingOccurrences(of: "ü", with: "u")
                .replacingOccurrences(of: "ö", with: "o")
            return string
    }
}





