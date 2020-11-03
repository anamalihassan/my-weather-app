//
//  WeatherService.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import Foundation

protocol WeatherService {
    func fetchWeatherInformation(latitude: Double, longitude: Double, completion: @escaping (WeatherResult?, Error?) -> () )
}

class WeatherServiceImpl: WeatherService {
    
    func fetchWeatherInformation(latitude: Double, longitude: Double, completion : @escaping (WeatherResult?, Error?) -> ()){
        let weatherURL = URL(string: "https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/\(latitude),\(longitude)")!
        URLSession.shared.dataTask(with: weatherURL) { (data, urlResponse, error) in
            if let error = error {
                completion(nil, error)
                return
            }
    
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let weatherData = try! jsonDecoder.decode(WeatherResult.self, from: data)
                completion(weatherData, nil)
            }
        }.resume()
    }
    
}
