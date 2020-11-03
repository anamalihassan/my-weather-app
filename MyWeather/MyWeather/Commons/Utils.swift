//
//  Utils.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import UIKit

class Utils {
    static func roundTempToString(_ temperature: Double) -> String {
        return String(Int(round(temperature)))
    }
    
    static func formatToHourlyTime(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        return dateFormatter.string(from: date)
    }
    
    static func formatToDailyTime(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    static func getWeatherImage(_ icon: String) -> UIImage? {
        var systemImage = "cloud.rain"
        
        switch icon {
        case "clear-day":
            systemImage = "sun.min.fill"
        case "partly-cloudy-day":
            systemImage = "cloud.sun.fill"
        case "partly-cloudy-night":
            systemImage = "cloud.moon.fill"
        case "rain":
            systemImage = "cloud.rain.fill"
        case "cloudy":
            systemImage = "cloud.fill"
        case "clear-night":
            systemImage = "moon.fill"
        case "clear":
            print("clear")
            systemImage = "sun.min.fill"
        default:
            systemImage = "sun.min.fill"
        }
        
        return UIImage(systemName: systemImage)
    }
}
