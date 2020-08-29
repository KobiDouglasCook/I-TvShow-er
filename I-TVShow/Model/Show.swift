//
//  Show.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import Foundation


struct Show: Decodable {
    
    let id: Int
    let name: String
    let premiered: String
    let summary: String
    let genres: [String]
    let network: Network
    let images: Images
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case premiered
        case summary
        case genres
        case network
        case images = "image"
    }
}

struct Network: Decodable {
    let name: String
    let info: CountryInfo
    
    private enum CodingKeys: String, CodingKey {
        case name
        case info = "country"
    }
    
}

struct CountryInfo: Decodable {
    let name: String
    let timezone: String
}

struct Images: Decodable {
    let medium: String
    let original: String
}
