//
//  Network.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 31/05/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Network {
    
    var url: String = "https://api.forecast.io/forecast/"
    var apiKey: String = "57ca143fe85ccc195581b271e6c44f85"
    
    func myRequest(args: String, completion: (result: JSON?, statusCode: Int?) -> Void) {
        Alamofire.request(.GET, url + apiKey + args)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        completion(result: json, statusCode: response.response?.statusCode)
                    }
                case .Failure:
                    print(response.data) // Error message
                    completion(result: nil, statusCode: response.response?.statusCode)
                }
        }
    }
}