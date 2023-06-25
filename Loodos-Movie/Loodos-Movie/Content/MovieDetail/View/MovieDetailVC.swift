//
//  MovieDetailVC.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import UIKit

class MovieDetailVC: ViewController<MovieDetailVM> {
    
    private lazy var moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setImage(from: viewModel.movie.poster)
        return imageView
    }()
    
    private lazy var propertiesHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 4.0
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI(){
        if let title = viewModel.movie.title {
            self.title = title
        }
        view.addSubview(moviePosterImageView)
        moviePosterImageView.snp.makeConstraints { make in
            make.width.equalTo(self.view.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.moviePosterImageView.snp.width).multipliedBy(1.5)
            make.center.equalToSuperview()
        }
        
        view.addSubview(propertiesHStackView)
        propertiesHStackView.snp.makeConstraints { make in
            make.top.equalTo(self.moviePosterImageView.snp.bottom).offset(10.0)
            make.width.equalTo(self.moviePosterImageView.snp.width)
            make.centerX.equalToSuperview()
            make.height.equalTo(30.0)
        }
    }
    
    private func configureUI() {
        viewModel.movie.properties.forEach {
            let propertyView = PropertyView(property: $0)
            propertyView.translatesAutoresizingMaskIntoConstraints = false
            self.propertiesHStackView.addArrangedSubview(propertyView)
        }
    }
}
