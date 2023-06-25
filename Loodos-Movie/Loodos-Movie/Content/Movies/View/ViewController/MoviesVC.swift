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
        searchBar.tintColor = .colorPrimary
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
        title = "Movies".localized
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = moviesSpacing
        layout.minimumLineSpacing = moviesSpacing
        moviesCollectionView.collectionViewLayout = layout
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MovieCollectionViewCell.self)
    }
    
    private func configureUI() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50.0)
        }
        
        view.addSubview(moviesCollectionView)
        moviesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(10.0)
            make.bottom.equalToSuperview()
        }
        toSearchState()
    }
    
    private func configureBindings() {
        viewModel.onStateChanged = {[weak self] state in
            switch state {
            case .moviesLoaded:
                DispatchQueue.main.async {
                    if self?.viewModel.movies.isEmpty ?? true {
                        self?.toNoDataFoundState()
                    }else{
                        self?.moviesCollectionView.clearBackground()
                    }
                    self?.moviesCollectionView.reloadData()
                }
                break
            case .showSearch:
                DispatchQueue.main.async {
                    self?.moviesCollectionView.reloadData()
                    self?.toSearchState()
                }
                break
            }
        }
    }
    
    private func toSearchState() {
        moviesCollectionView.showBannerMessage(message: "search_banner_message".localized)
    }
    
    private func toNoDataFoundState() {
        view.endEditing(true)
        let message = "noData_banner_message".localized
        let formattedMessage = String(format: message, searchBar.text ?? "")
        moviesCollectionView.showBannerMessage(message: formattedMessage)
    }
    
    private func endEditingSearchBar() {
        searchBar.showsCancelButton = false
        view.endEditing(true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModel.movies[safe: indexPath.row] {
            let vm = MovieDetailVM(with: movie)
            let vc = MovieDetailVC(viewModel: vm)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            viewModel.totalCount > collectionView.visibleCells.count,
            indexPath.row > viewModel.movies.count - 2
        else {
            return
        }
        viewModel.fetchMovies(with: searchBar.text ?? "", isNextPage: true)
    }
}

extension MoviesVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchMovies(with: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endEditingSearchBar()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditingSearchBar()
    }
}
