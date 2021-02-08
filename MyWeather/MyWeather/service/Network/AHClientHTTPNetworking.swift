//
//  AHNetwork.swift
//  MyWeather
//
//  Created by Ali Hassan on 08/02/2021.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding data"
        }
    }
}


extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}

protocol NHDataProvider {
    func fetchRemote<Model: Decodable>(_ val: Model.Type, url: URL, completion: @escaping (Result<Decodable, DataResponseError>) -> Void)
}

final class AHClientHTTPNetworking : NHDataProvider {
   
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRemote<Model: Decodable>(_ val: Model.Type, url: URL,
                         completion: @escaping (Result<Decodable, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(Model.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
