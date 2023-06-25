//
//  NetworkErrorModel.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

public protocol NetworkErrorModelResponseable: Codable{
    var message: String?{get set}
    var errorCode: Int?{get set}
}

public struct NetworkErrorModel: NetworkErrorModelResponseable {

    public var message: String?
    public var errorCode: Int?
    
    public init(message: String? = nil, errorCode: Int? = nil) {
        self.message = message
        self.errorCode = errorCode
    }
    
    public init(with error: NetworkError, message: String){
        errorCode = error.rawValue
        self.message = message
    }
}


public extension NetworkErrorModel{
    var errorType: NetworkError{
        guard let code = errorCode, let error = NetworkError.init(rawValue: code) else{
            return .bussinessError
        }
        return error
    }
}

public extension NetworkErrorModel{
    var canRequestRepeatable: Bool {
        errorType == .emptyContent || errorType == .failedResponse || errorType == .parseError
    }
}
