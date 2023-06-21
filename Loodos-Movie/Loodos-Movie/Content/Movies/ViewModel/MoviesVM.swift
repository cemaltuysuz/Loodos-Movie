//
//  MoviesVM.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 22.06.2023.
//

import Foundation

class MoviesVM: ViewModel {
    
    var pageNumber: Int = 1
    
    var repository: MoviesRepository = MoviesRepositoryImpl()
    
    func fetchMovies(with searchText: String) {
        
        repository.fetchMovies(searchText, page: pageNumber) {[weak self] result in
            switch result {
            case .success(let movies):
                print("success oldu")
                break
            case .failure(let error):
                print("fail oldu = \(error.message ?? "")")
                break
            }
        }
    }
}
