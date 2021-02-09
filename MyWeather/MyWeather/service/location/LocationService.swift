//
//  LocationService.swift
//  MyWeather
//
//  Created by Ali Hassan on 09/02/2021.
//

import Foundation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    // MARK: - Type Aliases
    
    typealias FetchLocationCompletion = (Location?, LocationServiceError?) -> Void
    
    // MARK: - Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}
