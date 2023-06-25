//
//  Movie.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 22.06.2023.
//

import Foundation

struct Movie : Codable {
    let title : String?
    let year : String?
    let imdbID : String?
    let type : String?
    let poster : String?

    enum CodingKeys: String, CodingKey {

        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}

extension Movie {
    var properties: [Property] {
        let year = Property(propertyValue: year ?? "", imageIcon: "calendar")
        let type = Property(propertyValue: type ?? "", imageIcon: "tv")
        return [year, type]
    }
}

