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
    private var pageNumber: Int = 1
    private var moviesResponse: MoviesResponse? {
        didSet{
            movies += moviesResponse?.movies ?? []
            onStateChanged?(.moviesLoaded)
        }
    }
    
    var onStateChanged: ((MoviesVCState)->Void)?
    
    var movies: [Movie] = []
    
    var totalCount: Int {
        moviesResponse?.resultCount ?? 0
    }
    
    func fetchMovies(with searchText: String, isNextPage: Bool = false) {
        searchWorkItem?.cancel()
        
        // check search test is empty
        if searchText.isEmpty {
            resetPagination()
            onStateChanged?(.showSearch)
            return
        }
        
        // check is this a new movie search ?
        if !isNextPage {
            resetPagination()
        }
        searchWorkItem = DispatchWorkItem {
            Process.shared.show()
            self.repository.fetchMovies(searchText, page: self.pageNumber) {[weak self] result in
                Process.shared.hide()
                switch result {
                case .success(let movies):
                    self?.moviesResponse = movies
                    self?.pageNumber += 1
                    break
                case .failure(let error):
                    if error.canRequestRepeatable {
                        self?.askRequestRepeat?{
                            self?.pageNumber -= 1
                            self?.fetchMovies(with: searchText, isNextPage: isNextPage)
                        }
                        return
                    }
                    self?.onErrorReceived?(error)
                    break
                }
                
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: searchWorkItem!)
    }
    
    func resetPagination() {
        pageNumber = 1
        movies = []
    }
}
