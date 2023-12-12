//
//  WebService.swift
//  PrayerTimes
//
//  Created by Safa on 1.12.2023.
//

import Foundation


protocol HttpService {
    func fetchDatas<T : Codable>(request req : URLRequest, type: T.Type, completition: @escaping (T?, ErrorType?) -> Void)
    func fetchDatasAsync<T : Codable>(request req : URLRequest, type: T.Type) async throws -> T
}


class WebService : HttpService {
        
    func fetchDatasAsync<T : Codable>(request req : URLRequest, type: T.Type) async throws -> T {
        
        let (data,response) =  try await URLSession.shared.data(for: req)

        guard let httpResponse = response as? HTTPURLResponse else{
            throw ErrorType.requestFailed(description : "Bad Http Request")
        }
                    
        guard httpResponse.statusCode == 200 else {
            throw ErrorType.invalidStatusCode(statusCode : httpResponse.statusCode)
        }

        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw ErrorType.invalidJSONParse
        }
        
        return result
        
    }
    
    
    
    
    
    /*---------------------------Fetching Data using completition Method-----------------------------*/

    /* Fetching data using Completition method, not be used in this application, but put here as an example in case of use */
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
    /*---------------------------/Fetching Data using completition Method-----------------------------*/

    
}

