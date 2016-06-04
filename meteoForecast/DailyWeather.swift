//
//  DailyWeather.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 31/05/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather {
    
    var day: String
    var icon: String
    var temperatureMax: Int
    var temperatureMin: Int
    var sunriseTime: String
    var sunsetTime: String
    var precipProbability: Double
    var humidity: Double
    var windSpeed: Double
    var precipIntensity: Double
    var pressure: Double
    var visibility: Double
}