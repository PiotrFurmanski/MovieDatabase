//
//  SynopsisView.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 14/02/2021.
//

import UIKit

class SynopsisView: UIView {
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
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
    }
    
    private func commontInit() {
        Bundle.main.loadNibNamed(String(describing: SynopsisView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        synopsisLabel.text = ""
        categoryLabel.text = ""
        lengthLabel.text = ""
    }

}
