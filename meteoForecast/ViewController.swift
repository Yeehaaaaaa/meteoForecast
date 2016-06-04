//
//  ViewController.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 29/05/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var currentUserLocation: String = ""
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var actualWeather: UILabel!

    var dailyWeather = [DailyWeather]()
    var hourlyWeather = [HourlyWeather]()
    var otherWeather: OtherWeather?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserLocation = getCurrentUserLocation()
        getWeatherCurrentLocation()
    }
    
    func getCurrentUserLocation() -> String {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        return "/37.8267,-122.423"
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locationManager.location?.coordinate.latitude != nil)
        && (locationManager.location?.coordinate.longitude != nil) {

            locationManager.stopUpdatingLocation()
            currentUserLocation = "/\((locationManager.location?.coordinate.latitude)!),\((locationManager.location?.coordinate.longitude)!)"
            getWeatherCurrentLocation()
        }
    }
    
    func getWeatherCurrentLocation() {
        
        let network = Network()
        network.myRequest(currentUserLocation) {
            (result: JSON?, statusCode: Int?) in
            
            if statusCode == 200 {
                self.fillHeader(result!)
                self.getCurrentInformations(result!)
                self.getHourlyWeather(result!)
                self.getDailyWeather(result!)
                self.passNewDatas()
            }
        }
    }
}

extension ViewController {
    
    func getHourlyWeather(result: JSON) {
        
        hourlyWeather = []
        let jsonHourly = result["hourly"]["data"]
        var time: Int?
        var icon: String?
        var temperature: Int?
        
        for (_, subJson) in jsonHourly {
            
            if let tmp = subJson["time"].double {
                time = Conversion().getHour(tmp)
            } else {
                time = 0
            }
            if let tmp = subJson["icon"].string {
                icon = tmp
            } else {
                icon = ""
            }
            if let tmp = subJson["temperature"].double {
                temperature = Conversion().fahrenheitToCelsius(tmp)
            } else {
                temperature = 0
            }
            let tmp = HourlyWeather(time: time!, icon: icon!, temperature: temperature!)
            hourlyWeather.append(tmp)
        }
    }
    
    func getDailyWeather(result: JSON) {
        
        dailyWeather = []
        let jsonHourly = result["daily"]["data"]
        var day: String?
        var icon: String?
        var temperatureMax: Int?
        var temperatureMin: Int?
        var sunriseTime: String?
        var sunsetTime: String?
        var precipProbability: Double?
        var humidity: Double?
        var windSpeed: Double?
        var precipIntensity: Double?
        var pressure: Double?
        var visibility: Double?
        
        for (_, subJson) in jsonHourly {
            
            if let tmp = subJson["time"].double {
                day = Days(rawValue: Conversion().getDaily(tmp))?.dayName
            } else {
                day = "Unknown"
            }
            if let tmp = subJson["icon"].string {
                icon = tmp
            } else {
                icon = ""
            }
            if let tmp = subJson["temperatureMax"].double {
                temperatureMax = Conversion().fahrenheitToCelsius(tmp)
            } else {
                temperatureMax = 0
            }
            if let tmp = subJson["temperatureMin"].double {
                temperatureMin = Conversion().fahrenheitToCelsius(tmp)
            } else {
                temperatureMin = 0
            }
            if let tmp = subJson["sunriseTime"].double {
                sunriseTime = String(Conversion().getHour(tmp)) + ":" + String(Conversion().getMin(tmp))
            } else {
                sunriseTime = ""
            }
            if let tmp = subJson["sunsetTime"].double {
                sunsetTime = String(Conversion().getHour(tmp)) + ":" + String(Conversion().getMin(tmp))
            } else {
                sunsetTime = ""
            }
            if let tmp = subJson["precipProbability"].double {
                precipProbability = tmp
            } else {
                precipProbability = 0
            }
            if let tmp = subJson["humidity"].double {
                humidity = tmp
            } else {
                humidity = 0
            }
            if let tmp = subJson["windSpeed"].double {
                windSpeed = tmp
            } else {
                windSpeed = 0
            }
            if let tmp = subJson["precipIntensity"].double {
                precipIntensity = tmp
            } else {
                precipIntensity = 0
            }
            if let tmp = subJson["pressure"].double {
                pressure = tmp
            } else {
                pressure = 0
            }
            if let tmp = subJson["visibility"].double {
                visibility = tmp
            } else {
                visibility = 0
            }
            let tmp = DailyWeather(day: day!, icon: icon!, temperatureMax: temperatureMax!, temperatureMin: temperatureMin!, sunriseTime: sunriseTime!, sunsetTime: sunsetTime!, precipProbability: precipProbability!, humidity: humidity!, windSpeed: windSpeed!, precipIntensity: precipIntensity!, pressure: pressure!, visibility: visibility!)
            dailyWeather.append(tmp)
        }
    }
    
    func getCurrentInformations(result: JSON) {
        
        var day: String?
        var degrees: Int?
        var summary: String?
        
        if let tmp = Days(rawValue: Conversion().getDaily(result["currently"]["time"].double!)) {
            day = String(tmp)
        } else {
            day = "Unknown"
        }
        if let tmp = result["currently"]["temperature"].double {
            degrees = Conversion().fahrenheitToCelsius(tmp)
        } else {
            degrees = 0
        }
        if let tmp = result["daily"]["summary"].string {
            summary = Conversion().convertDegreesValue(tmp)
        } else {
            summary = "Unknown"
        }
        otherWeather = OtherWeather(currentDegrees: degrees!, currentDay: day!, dailySummary: summary!)
    }
    
    func fillHeader(result: JSON) {
        
        cityName.text = result["timezone"].string
        actualWeather.text = result["currently"]["summary"].string
    }
    
    func passNewDatas() {
        
        let svc: MeteoTableViewController = self.childViewControllers[0] as! MeteoTableViewController
        
        svc.otherWeather = self.otherWeather
        svc.dailyWeather = self.dailyWeather
        svc.hourlyWeather = self.hourlyWeather
        svc.tableView.reloadData()
    }
}




