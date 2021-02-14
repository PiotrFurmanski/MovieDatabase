//
//  SynopsisView.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 14/02/2021.
//

import UIKit

class SynopsisView: UIView {
    @IBOutlet private weak var synopsisLabel: UILabel!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var lengthLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var reviewsLabel: UILabel!
    @IBOutlet private weak var scoreNameLabel: UILabel!
    @IBOutlet private weak var votesNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commontInit()
    }
    
    func setup(movie: MovieDetailsModel?) {
        guard let movie = movie else { return }
        synopsisLabel.text = movie.plot
        categoryLabel.text = movie.genre
        lengthLabel.text = movie.runtime
        scoreLabel.text = movie.imdbRating
        reviewsLabel.text = movie.imdbVotes
        scoreNameLabel.isHidden = false
        votesNameLabel.isHidden = false
    }
    
    private func commontInit() {
        Bundle.main.loadNibNamed(String(describing: SynopsisView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        synopsisLabel.text = ""
        categoryLabel.text = ""
        lengthLabel.text = ""
        scoreNameLabel.isHidden = true
        votesNameLabel.isHidden = true
    }

}
