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
    
    private var moviesCollectionView: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private let singleLineMovieCount: Int = 2
    private let moviesSpacing: CGFloat = 5.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        configureBindings()
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = moviesSpacing
        layout.minimumLineSpacing = moviesSpacing
        moviesCollectionView.collectionViewLayout = layout
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MovieCollectionViewCell.self)
        moviesCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func configureUI() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50.0)
        }
        
        view.addSubview(moviesCollectionView)
        moviesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureBindings() {
        viewModel.onStateChanged = { state in
            switch state {
            case .moviesLoaded:
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
                break
            case .showSearch:
                break
            }
        }
    }
}

extension MoviesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(MovieCollectionViewCell.self, indexPath: indexPath)
        let movie = viewModel.movies[safe: indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (CGFloat(singleLineMovieCount - 1) * moviesSpacing)
        let width = (collectionView.frame.width - totalSpacing) / CGFloat(singleLineMovieCount)
        let height = CGFloat(width * 1.7)
        return CGSize(width: width, height: height)
    }
}

extension MoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchMovies(with: searchText)
    }
}
