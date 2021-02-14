//
//  CreditsView.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 14/02/2021.
//

import UIKit

class CreditsView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
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
        directorLabel.text = "Director: \(movie.director)"
        writerLabel.text = "Writers: \(movie.writer)"
        actorsLabel.text = "Actors: \(movie.actors)"
    }
    
    private func commontInit() {
        Bundle.main.loadNibNamed(String(describing: CreditsView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        directorLabel.text = ""
        writerLabel.text = ""
        actorsLabel.text = ""
    }

}
