//
//  meteoTableViewController.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 30/05/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class MeteoTableViewController: UITableViewController, Meteo {
    
    var dailyWeather = [DailyWeather]()
    var hourlyWeather = [HourlyWeather]()
    var otherWeather: OtherWeather?
    
    private struct StoryBoard {
        static let degreesCell = "degreesCell"
        static let dailyCell = "dailyCell"
        static let hourlyHeader = "hourlyHeader"
        static let specificationCell = "specificationCell"
        static let summaryCell = "summaryCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        //print(dailyWeather[0].day)
    }
    
    func configureTableView() {
        tableView.estimatedRowHeight = 160.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.tableView.estimatedSectionHeaderHeight = 25
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.section {
            
        case 0:
            cell = getCurrentInformations(indexPath)
        case 1:
            if indexPath.row == 0 {
                cell = getDailyInformations(indexPath)
            } else if indexPath.row == 1 {
                cell = getSummaryInformations(indexPath)
            } else if indexPath.row == 2 {
                cell = getSpecificationInformations(indexPath)
            }
        default:
            break;
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.min
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerCell: UITableViewCell!
        
        switch section {
            
        case 0:
            headerCell = nil
        case 1:
            return getHourlyHeader()
        default:
            break;
        }
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellHeight: CGFloat
        
        switch indexPath.row {
        case 0:
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            cellHeight = (screenSize.height / 2) - 109
            break;
        default:
            cellHeight = UITableViewAutomaticDimension
            break;
        }
        return cellHeight
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if section == 1 {
            
            guard let tableViewHeader = view as? HourlyHeaderTableViewCell else { return }
            
            tableViewHeader.setCollectionViewDataSourceDelegate(self, forRow: section)
        }
    }
}

extension MeteoTableViewController {
    
    func getCurrentInformations(indexPath: NSIndexPath) -> CurrentInformationsTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.degreesCell, forIndexPath: indexPath) as! CurrentInformationsTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        if let tmp = otherWeather?.currentDegrees {
            cell.currentDegrees.text = String(tmp) + "º"
        } else {
            cell.currentDegrees.text = "Unknown"
        }
        if let tmp = otherWeather?.currentDay {
            cell.currentDay.text = tmp
        } else {
            cell.currentDay.text = "Unknown"
        }
        return cell
    }
    
    func getHourlyHeader() -> HourlyHeaderTableViewCell {
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.hourlyHeader) as! HourlyHeaderTableViewCell
        
        headerCell.backgroundColor = UIColor.clearColor()
        return headerCell
    }
    
    func getDailyInformations(indexPath: NSIndexPath) -> DailyTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.dailyCell, forIndexPath: indexPath) as! DailyTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()

        if dailyWeather.count > 0 {
            cell.day1.text = dailyWeather[1].day
            cell.day2.text = dailyWeather[2].day
            cell.day3.text = dailyWeather[3].day
            cell.day4.text = dailyWeather[4].day
            cell.day5.text = dailyWeather[5].day
            cell.day6.text = dailyWeather[6].day
            cell.day7.text = dailyWeather[7].day
            
            cell.icon1.image = UIImage(named: dailyWeather[1].icon)
            cell.icon2.image = UIImage(named: dailyWeather[2].icon)
            cell.icon3.image = UIImage(named: dailyWeather[3].icon)
            cell.icon4.image = UIImage(named: dailyWeather[4].icon)
            cell.icon5.image = UIImage(named: dailyWeather[5].icon)
            cell.icon6.image = UIImage(named: dailyWeather[6].icon)
            cell.icon7.image = UIImage(named: dailyWeather[7].icon)

            cell.degrees1.text = String(dailyWeather[1].temperatureMax) + "  " + String(dailyWeather[1].temperatureMin)
            cell.degrees2.text = String(dailyWeather[2].temperatureMax) + "  " + String(dailyWeather[2].temperatureMin)
            cell.degrees3.text = String(dailyWeather[3].temperatureMax) + "  " + String(dailyWeather[3].temperatureMin)
            cell.degrees4.text = String(dailyWeather[4].temperatureMax) + "  " + String(dailyWeather[4].temperatureMin)
            cell.degrees5.text = String(dailyWeather[5].temperatureMax) + "  " + String(dailyWeather[5].temperatureMin)
            cell.degrees6.text = String(dailyWeather[6].temperatureMax) + "  " + String(dailyWeather[6].temperatureMin)
            cell.degrees7.text = String(dailyWeather[7].temperatureMax) + "  " + String(dailyWeather[7].temperatureMin)
        }
        return cell
    }
    
    func getSpecificationInformations(indexPath: NSIndexPath) -> SpecificationViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.specificationCell, forIndexPath: indexPath) as! SpecificationViewCell

        if dailyWeather.count > 0 {
            cell.sunrise.text = dailyWeather[0].sunriseTime
            cell.sunset.text = dailyWeather[0].sunsetTime
            cell.chanceOfRain.text = String(dailyWeather[0].precipProbability)
            cell.humidity.text = String(dailyWeather[0].humidity)
            cell.pressure.text = String(dailyWeather[0].pressure)
            cell.precipitation.text = String(dailyWeather[0].precipIntensity)
            cell.visibility.text = String(dailyWeather[0].visibility)
            cell.wind.text = String(dailyWeather[0].windSpeed)
        }
        return cell
    }
    
    func getSummaryInformations(indexPath: NSIndexPath) -> SummaryViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.summaryCell, forIndexPath: indexPath) as! SummaryViewCell

        if (otherWeather?.dailySummary != nil) {
            cell.summary.text = "Week: " + (otherWeather?.dailySummary)!
        }
        return cell
    }
}

extension MeteoTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if hourlyWeather.count > 0 {
            return 25
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("weatherCell", forIndexPath: indexPath) as! DaysCollectionView
        
        if indexPath.row == 0 {
            cell.time.text = "now"
        } else {
            if String(hourlyWeather[indexPath.row].time).characters.count == 1 {
                cell.time.text = "0" + String(hourlyWeather[indexPath.row].time)
            } else {
                cell.time.text = String(hourlyWeather[indexPath.row].time)
            }
        }
        cell.degrees.text = String(hourlyWeather[indexPath.row].temperature) + "º"
        cell.icon.image = UIImage(named: hourlyWeather[indexPath.row].icon)
        return cell
    }
}




