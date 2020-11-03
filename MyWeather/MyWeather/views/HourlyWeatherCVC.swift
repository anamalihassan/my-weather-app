//
//  HourlyWeatherCVC.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import UIKit

class HourlyWeatherCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    var hourlyWeatherDettail:WeatherDetail? {
        didSet {
            guard let hourlyWeather = hourlyWeatherDettail else {return}
            if let timeStamp = hourlyWeather.time {
                timeLabel.text = Utils.formatToHourlyTime(timeStamp)
            }
            
            if let temperature = hourlyWeather.temperature {
                tempLabel.text = Utils.roundTempToString(temperature) + "°"
            }
            
            if let icon = hourlyWeather.icon {
                weatherImageView.image = Utils.getWeatherImage(icon)
            }
        }
    }
    
    let weatherImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = appPrimaryColor
        return img
    }()

    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = appPrimaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor =  appPrimaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - View Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
}

// MARK: - UI Setup

extension HourlyWeatherCVC {
    private func setupUI() {
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 5),
    
            weatherImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
        
    }
}
