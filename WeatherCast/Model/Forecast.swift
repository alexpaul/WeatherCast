//
//  Forecast.swift
//  WeatherCast
//
//  Created by Alex Paul on 11/1/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//
//  Forecast model

import Foundation

struct Forecast {
    var minTempF: Int = 0
    var minTempC: Int = 0
    var maxTempF: Int = 0
    var maxTempC: Int = 0
    var dateTimeISO: String = ""
    var icon: String = "" // image icon name 
}
