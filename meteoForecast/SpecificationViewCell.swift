//
//  SpecificationViewCell.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 01/06/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class SpecificationViewCell: UITableViewCell {
    
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!

    @IBOutlet weak var chanceOfRain: UILabel!
    @IBOutlet weak var humidity: UILabel!

    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var visibility: UILabel!
}