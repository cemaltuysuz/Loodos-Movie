//
//  NetworkError.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

public enum NetworkError: Int, Error {
    case bussinessError = 100
    case invalidURL = 101
    case failedResponse = 102
    case parseError = 103
    case emptyContent = 104
}

extension NetworkError {
    
    var config: OopsConfig {
        switch self {
        case .emptyContent:
            return OopsConfig(animName: "", title: "Oops!".localized, description: "It looks like no results were found.".localized)
        default:
            return OopsConfig(animName: "", title: "Information".localized, description: "Something went wrong.".localized)
        }
    }
}
