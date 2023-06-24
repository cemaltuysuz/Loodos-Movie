//
//  MoviesResponse.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 22.06.2023.
//

import Foundation

struct MoviesResponse : Decodable {
    let movies : [Movie]?
    let totalResults : String?

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults = "totalResults"
    }
}

extension MoviesResponse {
    var resultCount: Int {
        guard
            let results = totalResults,
            let count = Int(results)
        else {
            return 0
        }
        return count
    }
}
