//
//  CacheService.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import UIKit

typealias ImageHandler = (Result<UIImage?,ServiceErrors>) -> Void
let sharedCacheService = CacheService.shared

final class CacheService {
    
    static let shared = CacheService()
    private let cache = NSCache<NSString, NSData>()
    lazy var urlSession: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    private init() {}
    
    func download(from endpoint: String, completion: @escaping ImageHandler) {
        
        //1. check if image exists in cache
        if let data = cache.object(forKey: endpoint as NSString) {
            let image = UIImage(data: data as Data)
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(ServiceErrors.badData("bad endpoint")))
            return
        }
        
        //2. if not, make api request
        urlSession.dataTask(with: url) { (dat, _, _) in
            if let data = dat {
                
                //3. put key value pair in cache
                self.cache.setObject(data as NSData, forKey: endpoint as NSString)
                
                let image = UIImage(data: data)
                //4. return result to closure
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
        }.resume()
    }
}
