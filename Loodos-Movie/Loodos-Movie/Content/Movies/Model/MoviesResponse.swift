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
