//
//  WeatherResult.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import Foundation

struct WeatherResult: Decodable {
    let latitude: Double?
    let longitude: Double?
    let timezone: String?
    let currently: WeatherDetail?
    let hourly: TimelyWeather?
    let daily: TimelyWeather?
}


struct TimelyWeather: Decodable {
    let summary: String?
    let icon: String?
    let data: [WeatherDetail]?
}


struct WeatherDetail: Decodable {
    let time: Double?
    let summary: String?
    let icon: String?
    let precipIntensity: Double?
    let precipProbability: Double?
    let temperature: Double?
    let apparentTemperature: Double?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windGust: Double?
    let windBearing: Int?
    let cloudCover: Double?
    let uvIndex: Int?
    let visibility: Double?
    let ozone: Double?
    let temperatureMin: Double?
    let temperatureMax: Double?
    
}
