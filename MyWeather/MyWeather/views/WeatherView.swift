//
//  WeathView.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import UIKit

public class WeatherView: UIView {
    
    // MARK: - Properties
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = appPrimaryColor
        label.textAlignment = .center
        label.accessibilityIdentifier = "locationLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textColor = appPrimaryColor
        label.textAlignment = .center
        label.accessibilityIdentifier = "summaryLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 25)
        label.textColor = appPrimaryColor
        label.textAlignment = .center
        label.accessibilityIdentifier = "tempLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let apparentTempLabel: UILabel  = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textColor = appPrimaryColor
        label.textAlignment = .center
        label.accessibilityIdentifier = "apparentTempLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - View Initializer
    
      public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(locationLabel)
        addSubview(summaryLabel)
        addSubview(tempLabel)
        addSubview(apparentTempLabel)
        let spacing: CGFloat = 3
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo:self.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor),
        
            summaryLabel.topAnchor.constraint(equalTo:locationLabel.bottomAnchor, constant: spacing),
            summaryLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            
            tempLabel.topAnchor.constraint(equalTo:summaryLabel.bottomAnchor, constant: spacing),
            tempLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            
            apparentTempLabel.topAnchor.constraint(equalTo:tempLabel.bottomAnchor, constant: spacing),
            apparentTempLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            apparentTempLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            
            self.bottomAnchor.constraint(equalTo: apparentTempLabel.bottomAnchor),
        ])
      }
    
    
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

