//
//  WebService.swift
//  PrayerTimes
//
//  Created by Safa on 1.12.2023.
//

import Foundation


protocol HttpService {
    func fetchDatas<T : Codable>(request req : URLRequest, type: T.Type, completition: @escaping (T?, ErrorType?) -> Void)}



class WebService : HttpService {
    
    
    func fetchDatas<T : Codable>(request req : URLRequest, type: T.Type, completition: @escaping (T?, ErrorType?) -> Void) {
   
 
        URLSession.shared.dataTask(with: req) { (data, response, error) in
                
                if let error = error {
                    completition(nil, .someError(error : error))
                    return
                }
            
                guard let httpResponse = response as? HTTPURLResponse else{
                    completition(nil, .requestFailed(description : "Bad Http Request"))
                    return
                }
                        
                guard httpResponse.statusCode == 200 else {
                    completition(nil, .invalidStatusCode(statusCode : httpResponse.statusCode))
                    return
                }
                        
                guard let data = data  else {
                    completition(nil, .invalidData)
                    return
                }
  
                        
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completition(result, nil)
                } catch {
                    print(error.localizedDescription)
                    completition(nil, .invalidJSONParse)
                }
                        
                        
            

                
            }.resume()
            
    }
        
        
}

