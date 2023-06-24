//
//  MoviesVM.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 22.06.2023.
//

import Foundation

class MoviesVM: ViewModel {
        
    private var searchWorkItem: DispatchWorkItem?
    private let repository: MoviesRepository = MoviesRepositoryImpl()
    private var moviesResponse: MoviesResponse? {
        didSet{
            onStateChanged?(.moviesLoaded)
        }
    }
    
    var onStateChanged: ((MoviesVCState)->Void)?
    
    var movies: [Movie] {
        moviesResponse?.movies ?? []
    }
    
    var totalCount: Int {
        moviesResponse?.resultCount ?? 0
    }
    
    private var pageNumber: Int = 1

    
    func fetchMovies(with searchText: String, isNextPage: Bool = false) {
        searchWorkItem?.cancel()
        pageNumber = isNextPage ? pageNumber + 1 : pageNumber
        searchWorkItem = DispatchWorkItem {
            self.repository.fetchMovies(searchText, page: self.pageNumber) {[weak self] result in
                switch result {
                case .success(let movies):
                    self?.moviesResponse = movies
                    break
                case .failure(let error):
                    print("fail oldu = \(error.message ?? "")")
                    break
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: searchWorkItem!)
    }
}
