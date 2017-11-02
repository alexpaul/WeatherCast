//
//  ForecastViewModel.swift
//  WeatherCast
//
//  Created by Alex Paul on 11/1/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//
//  View model manages the Forecast model object 

import Foundation

protocol ForecastViewModelDelegate: class  {
    func didFinishFetchingForecasts()
}

class ForecastViewModel {
    
    weak var delegate: ForecastViewModelDelegate?
    
    public var forecasts = [Forecast]() {
        didSet {
            print("there are \(forecasts.count) results")
        }
    }
    
    public var forecastsCount: Int {
        return forecasts.count
    }
    
}

extension ForecastViewModel {
    
    public func getWeather() {
        AerisWeatherAPI.getWeatherForecasts { (theResponse, theErrorDict, theError) in
            if let error = theError {
                print("error: \(error.localizedDescription)")
            } else if let errorDict = theErrorDict {
                print("errorDict: \(errorDict)")
            } else if let responseArray = theResponse {
                self.forecasts = self.parseForecastsFromJSON(responseArray: responseArray)
                self.delegate?.didFinishFetchingForecasts()
            }
        }
    }
    
    fileprivate func parseForecastsFromJSON(responseArray: [Any]) -> [Forecast] {
        var forecasts = [Forecast]()
        // one result in response array
        if let resultDict = responseArray.first as? [String: Any] {
            if let periods = resultDict["periods"] as? [Any] {
                for period in periods {
                    var forecast = Forecast(minTempF: 0, minTempC: 0, maxTempF: 0, maxTempC: 0, dateTimeISO: "", icon: "")
                    if let periodDict = period as? [String : Any] {
                        if let minTempF = periodDict["minTempF"] as? Int {
                            forecast.minTempF = minTempF
                        }
                        if let minTempC = periodDict["minTempC"] as? Int {
                            forecast.minTempC = minTempC
                        }
                        if let maxTempF = periodDict["maxTempF"] as? Int {
                            forecast.maxTempF = maxTempF
                        }
                        if let maxTempC = periodDict["maxTempC"] as? Int {
                            forecast.maxTempC = maxTempC
                        }
                        if let dateTimeISO = periodDict["dateTimeISO"] as? String {
                            forecast.dateTimeISO = dateTimeISO
                        }
                        if let icon = periodDict["icon"] as? String {
                            forecast.icon = icon
                        }
                    }
                    forecasts.append(forecast)
                }
            }
        }
        return forecasts
    }
    
    public func getDateString(isoDate: String) -> String {
        let date = ISO8601DateFormatter().date(from: isoDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE-MMM-dd"
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    public func forecastDescription(forecast: Forecast, isCelcius: Bool) -> String {
        if !isCelcius {
            return "\(forecast.minTempF), " + "\(forecast.maxTempF), " + "\(getDateString(isoDate: forecast.dateTimeISO))"
        } else {
            return "\(forecast.minTempC), " + "\(forecast.maxTempC), " + "\(getDateString(isoDate: forecast.dateTimeISO))"
        }
    }
    
    public func getForecasts() -> [Forecast] {
        return forecasts
    }
}
