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
    @IBOutlet private weak var searchField: UITextField!
    
    
    private struct Constants {
        static let ok = "OK"
        static let cellHeight: CGFloat = 250
        static let segue = "MovieDetails"
    }
    
    private lazy var viewModel: MovieListViewModelProtocol = {
        MovieListViewModel(service: MovieService(), delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupData()
        setupCollectionView()
        searchField.delegate = self
    }
    
    private func setupData() {
        collectionView.register(UINib(nibName: String(describing: MovieListCell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: MovieListCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupCollectionView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.backgroundColor = .white
    }
    
    @objc func refresh() {
        if let text = searchField.text {
            viewModel.loadData(for: text, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let movieDetailsVC = segue.destination as? MovieDetailsViewController,
              let index = sender as? Int else { return }
        movieDetailsVC.movieModel = viewModel.movieModels[index]
        movieDetailsVC.cachedImage = viewModel.cellViewModel.cachedImage.object(forKey: viewModel.movieModels[index].imdbID as NSString)
    }
}

extension MovieListViewController: ReloadViewProtocol {
    func startLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func reload() {
        collectionView.reloadData()
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
        
        cell.setup(movie: viewModel.movieModels[indexPath.row],
                   viewModel: viewModel.cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segue, sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            if let text = searchField.text {
                viewModel.loadMoreData(for: text, completion: nil)
            }
        }
    }
    
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.size.width/2.2, height: Constants.cellHeight)
    }
}

extension MovieListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            viewModel.loadData(for: text, completion: nil)
        }
        textField.resignFirstResponder()
        return true
    }
}

