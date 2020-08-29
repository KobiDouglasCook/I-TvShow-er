//
//  TvService.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import Foundation

//service errors
enum ServiceErrors: Error {
    case badURL(String)
    case badData(String)
    case badShow(String)
}

//type aliases
typealias ShowHandler = (Result<Show, ServiceErrors>) -> Void
let sharedTvService = TvService.shared

final class TvService {
    
    
    static let shared = TvService()
    private init() {}
    
    //show get function
    func get(_ query: String, completion: @escaping ShowHandler) {
        
        guard let url = TvApi(query).url else {
            completion(.failure(.badURL("bad url")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                completion(.failure(.badData(error.localizedDescription)))
                return
            }
            
            if let data = dat {
                do {
                    let show = try JSONDecoder().decode(Show.self, from: data)
                    completion(.success(show))
                } catch {
                    completion(.failure(.badShow(error.localizedDescription)))
                    return
                }
            }
        }.resume()
    }
     
}
