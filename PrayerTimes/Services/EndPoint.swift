//
//  EndPoint.swift
//  PrayerTimes
//
//  Created by Safa on 5.12.2023.
//

import Foundation

/*
let headers = [
  "content-type": "application/json",
  "authorization": "apikey 2Wyw6ntUnM0ljtfOkuEAuX:7rekZl5MYoDe2h6fnawju"
]

let request = NSMutableURLRequest(url: NSURL(string: "https://api.collectapi.com/pray/all?data.city=\(city)")! as URL,
                                        cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
request.httpMethod = "GET"
request.allHTTPHeaderFields = headers
 
 */


protocol EndPointProtocol {
    
    var baseURL : String {get}
    var path : String {get}
    var method : Method {get}
    var headers : [String:String]? {get}
    
    func request() -> URLRequest
}

enum EndPoint {
    case getSalahs(city : String)
    case getWeathers //this one is added as an example
}

enum Method : String {
    case get = "GET"
    case post = "POST"
    case update = "PUT"
    case delete = "DELETE"
}


enum Path : String {
    case pathSalah = "/pray"
    case pathWeather = "/weather"
}





extension EndPoint : EndPointProtocol {
   
    var baseURL: String {
        return "https://api.collectapi.com"
    }
    
    var path: String {
        switch self {
        case .getSalahs(let city):
            return "\(Path.pathSalah.rawValue)/all?data.city=\(city)"
        case .getWeathers:
            return Path.pathWeather.rawValue
        }
    }
    
    var method: Method {
        switch self {
        case .getSalahs:
            return Method.get
        case .getWeathers:
            return Method.get
            
        }
    }
    
    var headers: [String : String]? {
        let header = ["content-type": "application/json",
                      "authorization": "apikey 2Wyw6ntUnM0ljtfOkuEAuX:7rekZl5MYoDe2h6fnawju4"]
        return header
    }

  
    func request() -> URLRequest {
        

        let request = NSMutableURLRequest(url: NSURL(string: "\(baseURL)\(path)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        
        return request as URLRequest
    }
    
    
    
}






