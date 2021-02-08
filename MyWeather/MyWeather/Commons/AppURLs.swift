//
//  AppURLs.swift
//  MyWeather
//
//  Created by Ali Hassan on 08/02/2021.
//

import Foundation

enum WeatherEndPoint: String {
    case forecast = "forecast"
}

struct AppURLs {
    
    private struct Domains {
        static let Dev = "https://api.darksky.net"
        static let UAT = "https://api.darksky.net"
//        static let Local = "192.145.1.1"
        static let QA = "https://api.darksky.net"
    }
    
    private  struct Routes {
        static let Api = "/"
        static let ApiImage = "/image/"
    }
    
    private  static let Domain = Domains.Dev
    private  static let DomainIamage = Domains.UAT
    private  static let Route = Routes.Api
    private  static let imageRoute = Routes.ApiImage
    private  static let BaseURL = Domain + Route
    private  static let BaseURLImage = DomainIamage + imageRoute
    
    static var FacebookLogin: String {
        return BaseURL  + ""
    }
    
    enum SmallImageDownload {
        case endpath(withName: String)
        var path: String {
            switch self {
            case let .endpath(withName):
                return BaseURLImage +  "/w45/" + withName
            }
        }
    }
    
    enum PosterImageDownload {
        case endpath(withName: String)
        var path: String {
            switch self {
            case let .endpath(withName):
                return BaseURLImage +  "/original/" + withName
            }
        }
    }
    
    //https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/59.337239,59.337239
    enum APIEndpoints {
        case getNowWeather(weather: String,latitude: Double, longitude: Double, key: String)
        var path: String {
            switch self {
            case let .getNowWeather(weather, latitude, longitude, key):
                return BaseURL  + "\(weather)/\(key)/\(latitude),\(longitude)"
            }
        }
    }
}
