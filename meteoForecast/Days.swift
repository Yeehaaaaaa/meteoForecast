//
//  Days.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 31/05/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

enum Days: Int, CustomStringConvertible {
    
    case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    
    var dayName: String {
        switch self {
        case .Sunday:
            return "Sunday"
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        }
    }
    var description: String {
        return self.dayName
    }

}