//
//  MovieDetailsViewController.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 12/02/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    
    private struct Constants {
        static let ok = "OK"
    }
    
    var movieModel: MovieModel?
    var cachedImage: UIImage?
    
    private lazy var viewModel: MovieDetailsViewModelProtocol = {
        MovieDetailsViewModel(service: MovieService(), delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = cachedImage
        view.backgroundColor = .white
        setupData()
        setupCollectionView()
    }
    
    private func setupData() {
//        collectionView.register(UINib(nibName: String(describing: MovieListCell.self), bundle: nil),
//                                forCellWithReuseIdentifier: String(describing: MovieListCell.self))
//        collectionView.dataSource = self
//        collectionView.delegate = self
        if let movieModel = movieModel {
            viewModel.loadData(for: movieModel.imdbID, completion: nil)
        }
    }
    
    private func setupCollectionView() {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        collectionView.refreshControl = refreshControl
//        collectionView.backgroundColor = .white
    }
    
    @objc func refresh() {
//        viewModel.loadData(completion: nil)
    }
}

extension MovieDetailsViewController: ReloadViewProtocol {
    func reload() {
//        collectionView.reloadData()
    }
    
    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
//        collectionView.refreshControl?.endRefreshing()
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
