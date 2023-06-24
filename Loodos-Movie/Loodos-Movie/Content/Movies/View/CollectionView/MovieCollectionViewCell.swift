//
//  MovieCollectionViewCell.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Font.font(.cabinMedium, size: 15.0)
        label.textColor = .colorPrimary
        return label
    }()
    
    private lazy var contentVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(contentVStackView)
        contentVStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentVStackView.addArrangedSubview(movieImageView)
        movieImageView.snp.makeConstraints { make in
            make.height.equalTo(self.contentVStackView.snp.width).multipliedBy(1.6)
        }
        
        contentVStackView.addArrangedSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.height.equalTo(16.0)
        }
    }
    
    func configure(with movie: Movie?) {
        DispatchQueue.main.async {
            self.movieTitle.text = movie?.title
            self.movieImageView.setImage(from: movie?.poster)
        }
    }
}


