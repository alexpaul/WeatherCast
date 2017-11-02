//
//  ViewController.swift
//  WeatherCast
//
//  Created by Alex Paul on 11/1/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import UIKit

class WeatherFeedController: UIViewController {
    fileprivate let forecastViewModel = ForecastViewModel()

    @IBOutlet weak var weatherTableView: UITableView!
    
    fileprivate var isCelcius = false

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        forecastViewModel.delegate = self
        forecastViewModel.getWeather()
    }

    @IBAction func toggleWeatherUnit(_ sender: UIBarButtonItem) {
        if isCelcius {
            isCelcius = false
        } else {
            isCelcius = true
        }
        weatherTableView.reloadData()
    }
    
}

extension WeatherFeedController: ForecastViewModelDelegate {
    func didFinishFetchingForecasts() {
        weatherTableView.reloadData()
    }
}

extension WeatherFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastViewModel.forecastsCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let forecast = forecastViewModel.getForecasts()[indexPath.row]
        if !isCelcius {
            weatherCell.maxTempLabel.text = "\(forecast.maxTempF)F"
            weatherCell.minTempLabel.text = "\(forecast.minTempF)"
        } else {
            weatherCell.maxTempLabel.text = "\(forecast.maxTempC)C"
            weatherCell.minTempLabel.text = "\(forecast.minTempC)"
        }

        weatherCell.dateLabel.text = forecastViewModel.getDateString(isoDate: forecast.dateTimeISO)
        weatherCell.weatherIcon.image = UIImage(named: forecast.icon)
        return weatherCell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
//        let forecast = forecastViewModel.getForecasts()[indexPath.row]
//        cell.textLabel?.text = forecastViewModel.forecastDescription(forecast: forecast, isCelcius: isCelcius)
//        cell.imageView?.image = UIImage(named: forecast.icon)
//        return cell
    }
}

extension WeatherFeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.20
    }
}



