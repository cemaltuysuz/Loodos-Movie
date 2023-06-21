//
//  NetworkService+Movies.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

extension NetworkService {
    
    enum Movies {
        case searchMovie
        
        var config: NetworkServiceConfig {
            switch self {
            case .searchMovie:
                return .init(httpMethod: .get, url: NetworkService.moviesBase.url)
            }
        }
    }
}
