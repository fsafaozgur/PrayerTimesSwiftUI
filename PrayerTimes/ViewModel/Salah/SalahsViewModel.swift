//
//  SalahsViewModel.swift
//  PrayerTimes
//
//  Created by Safa on 1.12.2023.
//

import Foundation
import SwiftUI

class SalahsViewModel : ObservableObject{
    
    @Published var result : [Salah]?
    @Published var error : ErrorType?
    @Published var remainingSec : Int = 0
    @Published var date : String?
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var service : HttpService!
    
    init(service : HttpService) {
        self.service = service
        getDate()
    }
    
    func fetchTimesAsync(_ city: String) async throws {
        
        let city = trToEng(string: city)

        do{
            let data = try await service.fetchDatasAsync(request: EndPoint.getSalahs(city: city).request(), type:SalahObject.self)
            self.result = data.result
            calculateTimeToSalah()
        }catch (let error){
            self.error = error as? ErrorType
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
    
    
    
    //Get date of today
    func getDate() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        date = formatter.string(from: now)
    }
    
    
    //Calculate time to next salah
    func calculateTimeToSalah() {

        let calendar = Calendar.current
        let now = Date()
        let nowSecond = calendar.component(.second, from: now)
        let nowMinute = calendar.component(.minute, from: now)
        let nowHour = calendar.component(.hour, from: now)
        
        let nowTotal = nowHour * 3600 + nowMinute * 60 + nowSecond
        
        guard let result = result else {return}
        
        for salah in result {
            
            let array = salah.time.components(separatedBy: ":")
            let intArray = array.map { Int($0)}
            
            guard let salahHour = intArray[0], let salahMinute = intArray[1] else {return }
            
            let salahTotal = salahHour * 3600 + salahMinute * 60
            
            if nowTotal - salahTotal <= 0 {
                self.remainingSec = salahTotal - nowTotal
                break
            }

        }
    }
                
            
    
        
        
    
    
    
    
    
    
    /*---------------------------Fetching Data using completition Method-----------------------------*/

    /* Fetching data using Completition method, not be used in this application, but put here as an example and Unit Test of this completition method was added to project in case of use */
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
            
            service.fetchDatas(request: request as URLRequest, type:SalahObject.self) { data, error in
                
                if let error = error {
                    completition(.failure(error))
                }
                
                if let data = data {
                    completition(.success(data.result))
                }
            }
        }
    
    /*---------------------------/Fetching Data using completition Method-----------------------------*/

}





