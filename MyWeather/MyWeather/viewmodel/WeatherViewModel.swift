//
//  WeatherViewModel.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import Foundation

class WeatherViewModel {
    
    // MARK: - Properties
    var weatherResult: WeatherResult? {
        didSet {
            guard let weather = weatherResult else { return }
            self.setUpWeather(weather)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlert?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var dailyWeather = [WeatherDetail](){
        didSet {
            self.reloadDailyTableView?()
        }
    }
    
    var hourlyWeather = [WeatherDetail](){
        didSet {
            self.reloadHourlyCollectionView?()
        }
    }
    
    var hourlyWeatherCount: Int {
        return hourlyWeather.count
    }
    
    var dailyWeatherCount: Int {
        return dailyWeather.count
    }
    
    let weatherService: WeatherService
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var reloadDailyTableView: (()->())?
    var reloadHourlyCollectionView: (()->())?
    
    // MARK: - Constructor
    init( weatherService: WeatherService = WeatherServiceImpl()) {
        self.weatherService = weatherService
    }
    
    // MARK: - Network call
    func fetchWeatherInformation(latitude: Double, longitude: Double) {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.weatherService.fetchWeatherInformation(latitude: latitude, longitude: longitude, completion: { (weatherResult, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.weatherResult = weatherResult
        })
    }
    
    // MARK: - UI
    private func setUpWeather(_ weather: WeatherResult) {
        if let dailyWeather = weather.daily?.data{
            self.dailyWeather = dailyWeather
        }
        if let hourlyWeather = weather.hourly?.data{
            self.hourlyWeather = hourlyWeather
        }
    }
}

extension WeatherViewModel {
  public func configureWeatherView(_ view: WeatherView) {
    if let timezone = weatherResult?.timezone {
        view.locationLabel.text = timezone
    }
    if let summary = weatherResult?.currently?.summary {
        view.summaryLabel.text = summary
    }
    if let temperature = weatherResult?.currently?.temperature {
        view.tempLabel.text = Utils.roundTempToString(temperature) + "°F"
    }
    if let apparentTemperature = weatherResult?.currently?.apparentTemperature {
        view.apparentTempLabel.text = "Feels like " + Utils.roundTempToString(apparentTemperature) + "°"
    }
  }
}

