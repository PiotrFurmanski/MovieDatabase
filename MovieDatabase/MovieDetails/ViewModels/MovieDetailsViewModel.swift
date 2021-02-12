//
//  MovieDetailsViewModel.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 12/02/2021.
//

import UIKit

protocol MovieDetailsViewModelProtocol: AnyObject {
    func loadData(for id: String, completion: (() -> ())?)
    var movieDetailsModel: MovieDetailsModel? { get }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    private(set) var movieDetailsModel: MovieDetailsModel?
    
    private weak var delegate: ReloadViewProtocol?
    private let service: MovieServiceProtocol
    let cellViewModel = MovieListCellViewModel()
    
    init(service: MovieServiceProtocol, delegate: ReloadViewProtocol) {
        self.service = service
        self.delegate = delegate
    }
    
    func loadData(for id: String, completion: (() -> ())? = nil) {
        service.getDetails(for: id) { [weak self] response in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let movieDetails):
                strongSelf.movieDetailsModel = movieDetails
                DispatchQueue.main.async {
                    strongSelf.delegate?.stopLoadingIndicator()
                    strongSelf.delegate?.reload()
                    completion?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.delegate?.stopLoadingIndicator()
                    strongSelf.delegate?.show(error: error.localizedDescription)
                    completion?()
                }
            }
        }
    }
    
}


