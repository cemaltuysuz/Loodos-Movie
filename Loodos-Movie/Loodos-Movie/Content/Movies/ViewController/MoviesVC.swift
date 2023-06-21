//
//  MoviesVC.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 22.06.2023.
//

import UIKit

class MoviesVC: ViewController<MoviesVM> {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Search".localized
        return searchBar
    }()
    
    private let moviesCollectionView: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
//        configureUI()
        viewModel.fetchMovies(with: "fast and")
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.estimatedItemSize = .zero
        moviesCollectionView.collectionViewLayout = layout
        
//        moviesCollectionView.delegate = self
//        moviesCollectionView.dataSource = self
        moviesCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func configureUI() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.edges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50.0)
        }
        
        view.addSubview(moviesCollectionView)
        moviesCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
//
//extension MoviesVC: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//}

extension MoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: Search
    }
}
