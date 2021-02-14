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
    @IBOutlet private weak var synopsisView: SynopsisView!
    @IBOutlet private weak var creditsView: CreditsView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    
    private struct Constants {
        static let ok = "OK"
        static let placeholder = "video"
    }
    
    var movieModel: MovieModel?
    var cachedImage: UIImage?
    
    private lazy var viewModel: MovieDetailsViewModelProtocol = {
        MovieDetailsViewModel(service: MovieService(), delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = cachedImage ?? UIImage(named: Constants.placeholder)
        view.backgroundColor = .white
        setupData()
    }
    
    private func setupData() {
        titleLabel.text = ""
        yearLabel.text = ""
        if let movieModel = movieModel {
            viewModel.loadData(for: movieModel.imdbID, completion: nil)
        }
    }
}

extension MovieDetailsViewController: ReloadViewProtocol {
    func startLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func reload() {
        titleLabel.text = viewModel.movieDetailsModel?.title
        yearLabel.text = viewModel.movieDetailsModel?.year
        synopsisView.setup(movie: viewModel.movieDetailsModel)
        creditsView.setup(movie: viewModel.movieDetailsModel)
    }
    
    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
