//
//  TvApi.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import Foundation


struct TvApi {
    
    var search: String!
    let base = "http://api.tvmaze.com/singlesearch/shows?q="
    
    init(_ query: String) {
        self.search = query
    }
    
    var url: URL? {
        guard let query = search else { return nil }
        return URL(string: base + query)
    }
}
