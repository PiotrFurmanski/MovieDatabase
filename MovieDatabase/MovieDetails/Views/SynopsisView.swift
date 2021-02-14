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
    }
    
    private func commontInit() {
        Bundle.main.loadNibNamed(String(describing: SynopsisView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        synopsisLabel.text = ""
    }

}
