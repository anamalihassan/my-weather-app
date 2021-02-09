//
//  LocationProvider.swift
//  MyWeather
//
//  Created by Ali Hassan on 09/02/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    // MARK: - Properties
    
    private var didFetchLocation: FetchLocationCompletion?

    // MARK: -
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.delegate = self
        
        return locationManager
    }()
    
    // MARK: - Location Service
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        // Store Reference to Completion
        self.didFetchLocation = completion
        
        // Fetch Location
        locationManager.requestLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            // Request Authorization
            locationManager.requestWhenInUseAuthorization()
            
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            // Fetch Location
            locationManager.requestLocation()
            
        } else {
            // Invoke Completion Handler
            didFetchLocation?(nil, .notAuthorizedToRequestLocation)
            
            // Reset Completion Handler
            didFetchLocation = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // Invoke Completion Handler
        didFetchLocation?(Location(location: location), nil)
        
        // Reset Completion Handler
        didFetchLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location (\(error))")
    }
    
}

fileprivate extension Location {
    
    // MARK: - Initialization
    
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
}

