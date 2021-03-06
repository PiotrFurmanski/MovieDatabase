//
//  MovieListCell.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 11/02/2021.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    private struct Constants {
        static let placeholder = "video"
        static let transitionDuration = 0.3
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    private var movieId = ""
    
    func setup(movie: MovieModel, viewModel: MovieListCellViewModel) {
        titleLabel.text = movie.title
        movieImageView.image = viewModel.cachedImage.object(forKey: movie.imdbID as NSString) ?? UIImage(named: Constants.placeholder)
        movieId = movie.imdbID
        
        guard viewModel.cachedImage.object(forKey: movie.imdbID as NSString) == nil else { return }
        movieImageView.contentMode = .scaleAspectFit
        viewModel.loadImage(urlString: movie.poster, id: movie.imdbID) { [weak self] (image, movieId) in
            guard let strongSelf = self, strongSelf.movieId == movieId else { return }
            if let image = image {
                strongSelf.movieImageView.contentMode = .scaleAspectFill
                UIView.transition(with: strongSelf.movieImageView,
                                  duration: Constants.transitionDuration,
                                  options: .transitionCrossDissolve, animations: {
                                    strongSelf.movieImageView.image = image
                                  })
            }
        }
    }

}
