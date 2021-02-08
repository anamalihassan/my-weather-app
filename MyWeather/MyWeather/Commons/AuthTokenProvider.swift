//
//  AuthTokenProvider.swift
//  MyWeather
//
//  Created by Ali Hassan on 08/02/2021.
//

import Foundation

let tokenClosure: () -> String = {
    AuthTokenProvider.Auth().token
}

class AuthTokenProvider {
    class func Auth() -> (isValidIn: Bool, token: String) {
        return (isValidIn: true, token: "2bb07c3bece89caf533ac9a5d23d8417")
    }
    
    //below going to implement token expire
}
