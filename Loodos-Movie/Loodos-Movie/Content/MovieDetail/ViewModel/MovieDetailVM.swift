//
//  MovieDetailVM.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import Foundation

class MovieDetailVM: ViewModel {
    
    var movie: Movie
    
    init(with movie: Movie) {
        self.movie = movie
        super.init()
        EventManager.shared.event(type: .movieViewed, value: movie.title ?? "")
    }
}
