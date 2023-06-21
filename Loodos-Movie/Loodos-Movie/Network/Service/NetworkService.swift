//
//  NetworkService.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

enum NetworkService {
    
    case moviesBase
    
    var url: String {
        switch self {
        case .moviesBase:
            return ""
        }
    }
}
