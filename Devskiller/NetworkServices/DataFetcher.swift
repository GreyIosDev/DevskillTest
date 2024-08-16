//
//  DataFetcher.swift
//  Devskiller
//
//  Created by Grey  on 16.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation
class DataFetcher {
    
    static func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            // Handle URL creation error
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                // Handle response error
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                self.decodeJSON(data: data, completion: completion)
            default:
                // Handle other status codes
                break
            }
        }
        task.resume()
    }
    
    static func decodeJSON<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let decodedData = try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}
