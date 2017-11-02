//
//  AerisWeatherAPI.swift
//  WeatherCast
//
//  Created by Alex Paul on 11/1/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//
//  Aeris Weather API fetches current forecast 

import Foundation
import Alamofire

struct APIKeys {
    static let kAccessId = "client_id"
    static let kSecretKey = "client_secret"
}

class AerisWeatherAPI {
    
    static let SECRET_KEY = "8vMvTmFECpm6eoDylc7YUYhBt8GjOhsSD8EUjUbx"
    static let ACCESS_ID = "tx6xdSS9R6ZHiQLbhM0Ao"
    static let forecastsBaseURL = "http://api.aerisapi.com/forecasts/11101?"
    
    static var parameters: [String : Any] = [APIKeys.kAccessId : AerisWeatherAPI.ACCESS_ID,
                                             APIKeys.kSecretKey : AerisWeatherAPI.SECRET_KEY
    ]
    
    static func getWeatherForecasts(completionHandler:@escaping ([Any]?,[String : Any]?, Error?) -> Void) {
        Alamofire.request(AerisWeatherAPI.forecastsBaseURL, method: .get, parameters: parameters, encoding:
            URLEncoding.default, headers: nil).responseJSON { (response) in
                if let error = response.result.error {
                    return completionHandler(nil, nil, error)
                }
                else if let value = response.result.value as? [String : Any] {
                    if let errorDict = value["error"] as? [String : Any] {
                        return completionHandler(nil, errorDict, nil) // contains an "error" and "code" string
                    }
                    else if let responseArray = value["response"] as? [Any] {
                        print(responseArray)
                        return completionHandler(responseArray, nil, nil)
                    }
                }
        }
    }
}
