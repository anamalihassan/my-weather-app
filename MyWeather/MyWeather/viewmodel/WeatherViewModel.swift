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
    var error: String? {
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
    
    private let weatherService: WeatherService
    private let locationService: LocationService
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var reloadDailyTableView: (()->())?
    var reloadHourlyCollectionView: (()->())?
    
    // MARK: - Constructor
    init( weatherService: WeatherService = WeatherService(weather: WeatherEndPoint.forecast.rawValue), locationService: LocationService = LocationManager()) {
        self.weatherService = weatherService
        self.locationService = locationService
        self.setUpService()
        self.fetchLocation()
    }
    private func setUpService() {
        self.weatherService.delegate = self
    }
    
    // MARK: -  Fetch Location
    
    private func fetchLocation() {
        locationService.fetchLocation { [weak self] (location, error) in
            if let error = error {
                print("Unable to Fetch Location (\(error))")
                self?.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
                // Invoke Completion Handler
//                self?.didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
                
            } else if let location = location {
//                 Invoke Completion Handler
                print("location fetched")
                self?.fetchWeatherInformation(latitude: location.latitude, longitude: location.longitude)
                
            } else {
                print("Unable to Fetch Location")
                self?.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
                
                // Invoke Completion Handler
//                self?.didFetchWeatherData?(nil, .failedToRequestLocation)
            }
        }
    }
    
    // MARK: - Network call
    func fetchWeatherInformation(latitude: Double, longitude: Double) {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.weatherService.fetchWeatherInformation(latitude: latitude, longitude: longitude)
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
extension WeatherViewModel: WeatherServiceDelegate {
    
    func onWeatherFetchCompleted(with weatherResult: WeatherResult) {
        self.isLoading = false
        self.weatherResult = weatherResult
    }
    
    
    func onFetchFailed(with reason: String) {
        self.isLoading = false
        self.error = reason
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

