//
//  DailyWeatherTVC.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import UIKit

class DailyWeatherTVC: UITableViewCell {
    
    // MARK: - Properties
    
    var weath:WeatherDetail? {
        didSet {
            guard let contactItem = weath else {return}
            if let timeStamp = contactItem.time {
                dayLabel.text = Utils.formatToDailyTime(timeStamp)
            }
            
            if let temperatureMax = contactItem.temperatureMax {
                maxTempLabel.text = Utils.roundTempToString(temperatureMax)
            }
            
            if let temperatureMin = contactItem.temperatureMin {
                minTempLabel.text = Utils.roundTempToString(temperatureMin)
            }
            
            if let icon = contactItem.icon {
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
    
    let dayLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = appPrimaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let maxTempLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor =  appPrimaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minTempLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor =  appSecondaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - View Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let tempSV = UIStackView()
        tempSV.translatesAutoresizingMaskIntoConstraints = false
        tempSV.axis = .horizontal
        tempSV.spacing = 25
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(dayLabel)
        self.contentView.addSubview(tempSV)
        
        tempSV.addArrangedSubview(maxTempLabel)
        tempSV.addArrangedSubview(minTempLabel)
    
        NSLayoutConstraint.activate([
            weatherImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            weatherImageView.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant:25),
            weatherImageView.heightAnchor.constraint(equalToConstant:25),
            dayLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:20),
            tempSV.heightAnchor.constraint(equalToConstant:26),
            tempSV.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20),
            tempSV.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}


