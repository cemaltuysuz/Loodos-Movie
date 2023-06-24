//
//  MoviesRepositoryImpl.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 22.06.2023.
//

import Foundation

class MoviesRepositoryImpl: MoviesRepository {
    
    func fetchMovies(_ searchText: String, page: Int, completionHandler: @escaping ((NetworkResult<MoviesResponse?, NetworkErrorModel>) -> Void)) {
        
        let urlParams: [String: String] = [
            "apikey" : Constants.moviesToken,
            "s" : searchText,
            "page" : "\(page)",
            "type" : "movie"
        ]
        let request = NetworkRequest(
            serviceConfig: NetworkService.Movies.searchMovie.config,
            urlParams: urlParams
        )
        
        NetworkManager.shared.sendRequest(request: request) { result in
            completionHandler(result)
        }
    }
}
