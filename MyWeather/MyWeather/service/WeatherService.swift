//
//  WeatherService.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import Foundation

protocol WeatherServiceDelegate: class {
    func onWeatherFetchCompleted(with weatherResult: WeatherResult)
    func onFetchFailed(with reason: String)
}

class WeatherService {
    weak var delegate: WeatherServiceDelegate?
    
    var client : NHDataProvider
    var weather : String
    init( weather: String, client : NHDataProvider = AHClientHTTPNetworking()) {
        self.weather = weather
        self.client = client
    }
    
    func fetchWeatherInformation(latitude: Double, longitude: Double) {
        let urlString = AppURLs.APIEndpoints.getNowWeather(weather: weather, latitude: latitude, longitude: latitude, key: tokenClosure()).path
        if let url = URL(string: urlString) {
            print(url)
            client.fetchRemote(WeatherResult.self, url: url) { result in
                switch result {
                case .failure(let error):
                    self.delegate?.onFetchFailed(with: error.reason)
                case .success(let response):
                    if let response = response as? WeatherResult {
                        self.delegate?.onWeatherFetchCompleted(with: response)
                    }
                }
            }
        }else{
            self.delegate?.onFetchFailed(with: Constants.APIMessages.InvalidURL)
        }
    }
}
