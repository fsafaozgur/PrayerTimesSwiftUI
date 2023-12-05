//
//  Mockable.swift
//  PrayerTimesTests
//
//  Created by Safa on 3.12.2023.
//

import Foundation
@testable import PrayerTimes


protocol Mockable : AnyObject {
    
    var bundle : Bundle {get}
    
    //func loadFromJSONAsync <T : Codable> (filename : String, type : T.Type) -> T

    func loadFromJSON <T : Codable> (filename : String, type : T.Type, completition: @escaping ((T?, ErrorType?) -> () ))
    
    
    
}


extension Mockable {
    
    var bundle : Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadFromJSONAsync <T : Codable> (filename : String, type : T.Type) throws -> T {
        
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            throw ErrorType.invalidData
        }
            
            
        do{
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        }catch (let error){
            throw error
        }
    }

    
    
    
    func loadFromJSON <T : Codable> (filename : String, type : T.Type, completition: @escaping ((T?, ErrorType?) -> () )) {
        
        if let path = bundle.url(forResource: filename, withExtension: "json"){
            
            
            do {
                let data = try Data(contentsOf: path)
                let result = try JSONDecoder().decode(T.self, from: data)
                completition(result, nil)
            } catch  {
                completition(nil, .invalidJSONParse)
            }
            
            
        }
        
    }
    
    
}
