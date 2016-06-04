//
//  Conversion.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 31/05/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class Conversion {
    
    func getHour(time: Double) -> Int {
        
        let date = NSDate(timeIntervalSince1970: time)
        return NSCalendar.currentCalendar().component(.Hour, fromDate: date)
    }
    
    func getMin(time: Double) -> Int {
        let date = NSDate(timeIntervalSince1970: time)
        return NSCalendar.currentCalendar().component(.Minute, fromDate: date)
    }
    
    func getDaily(time: Double) -> Int {
        
        let date = NSDate(timeIntervalSince1970: time)
        return NSCalendar.currentCalendar().component(.Weekday, fromDate: date)
    }
    
    func fahrenheitToCelsius(tempInF: Double) -> Int {
        let celsius = (tempInF - 32.0) * (5.0/9.0)
        return Int(celsius)
    }
    
    func convertDegreesValue(summary: String) -> String {
        
        let fullNameArr = summary.characters.split{$0 == " "}.map(String.init)
        var newSummaryConverted: String = ""
        
        for elem in fullNameArr {
            let stringArray = elem.componentsSeparatedByCharactersInSet(
                NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
            if stringArray != ""  && elem.characters.last == "F" {
                let numberConverted = fahrenheitToCelsius(Double(stringArray)!)
                newSummaryConverted += " " + String(numberConverted) + "°C"
                
            } else {
                if newSummaryConverted == "" {
                    newSummaryConverted += elem
                } else {
                    newSummaryConverted += " " + elem
                }
            }
        }
        return newSummaryConverted
    }
}