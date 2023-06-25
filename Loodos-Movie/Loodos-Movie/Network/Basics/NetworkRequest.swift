//
//  NetworkRequest.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

struct NetworkRequest {
    let serviceConfig: NetworkServiceConfig
    let urlParams: [String: String]?
    let timeOut: TimeInterval
    
    init(serviceConfig: NetworkServiceConfig,
         urlParams: [String: String]? = nil,
         timeOut: TimeInterval = 60.0) {
        self.serviceConfig = serviceConfig
        self.urlParams = urlParams
        self.timeOut = timeOut
    }
}
