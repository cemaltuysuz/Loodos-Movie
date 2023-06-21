//
//  NetworkService+Movies.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

extension NetworkService {
    
    enum Movies {
        case searchMovie(searchText: String)
        
        var config: NetworkServiceConfig {
            switch self {
            case .searchMovie(let searchText):
                let url = "\(NetworkService.moviesBase)?t=\(searchText)"
                return .init(httpMethod: .get, url: url)
            }
        }
    }
}
