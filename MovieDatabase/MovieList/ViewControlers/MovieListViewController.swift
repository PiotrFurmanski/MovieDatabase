//
//  MovieListViewController.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 10/02/2021.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    private struct Constants {
        static let ok = "OK"
        static let cellWidth: CGFloat = 100
        static let cellHeight: CGFloat = 250
    }
    
    private lazy var viewModel: MovieListViewModelProtocol = {
        MovieListViewModel(service: MovieService(), delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupData()
        setupCollectionView()
    }
    
    private func setupData() {
        collectionView.register(UINib(nibName: String(describing: MovieListCell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: MovieListCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.loadData(completion: nil)
    }
    
    private func setupCollectionView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.backgroundColor = .white
    }
    
    @objc func refresh() {
        viewModel.loadData(completion: nil)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func reload() {
        collectionView.reloadData()
    }
    
    func showDetails(for city: MovieModel, image: UIImage?) {
        //        let movieDetailsVC = MovieDetailsViewController()
        //        movieDetailsVC.movieModel = movie
        //        movieDetailsVC.movieCachedImage = image
        //        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
        collectionView.refreshControl?.endRefreshing()
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.movieModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieListCell.self),
                                                            for: indexPath) as? MovieListCell else { return UICollectionViewCell() }
        
        cell.setup(movie: viewModel.movieModels[indexPath.row], viewModel: viewModel.cellViewModel)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        showDetails(for: filteredCities[indexPath.row],
//                    image: cellViewModel.cachedImage[filteredCities[indexPath.row].cityId])
//    }
    
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.size.width/2.2, height: Constants.cellHeight)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    }
}

