//
//  NetworkResult.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

public enum NetworkResult<Success,Failure> where Failure: NetworkErrorModelResponseable{
    case success(Success)
    case failure(Failure)
}
