//
//  MoviesRepository.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 22.06.2023.
//

import Foundation

protocol MoviesRepository: AnyObject {
    func fetchMovies(_ searchText: String, page: Int, completionHandler: @escaping((NetworkResult<MoviesResponse?,NetworkErrorModel>)->Void))
}
