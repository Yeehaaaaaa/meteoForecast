//
//  Meteo.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 04/06/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

protocol Meteo {
    
    var dailyWeather: [DailyWeather] {get set}
    var hourlyWeather: [HourlyWeather] {get set}
    var otherWeather: OtherWeather? {get set}
    
    func configureTableView()
    func getCurrentInformations(indexPath: NSIndexPath) -> CurrentInformationsTableViewCell
    func getDailyInformations(indexPath: NSIndexPath) -> DailyTableViewCell
    func getSpecificationInformations(indexPath: NSIndexPath) -> SpecificationViewCell
    func getSummaryInformations(indexPath: NSIndexPath) -> SummaryViewCell
    func getHourlyHeader() -> HourlyHeaderTableViewCell
}