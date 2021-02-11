//
//  MovieListViewModel.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 11/02/2021.
//

import UIKit

protocol MovieListViewProtocol: AnyObject {
    func reload()
    func showDetails(for city: MovieModel, image: UIImage?)
    func stopLoadingIndicator()
    func show(error: String)
}

protocol MovieListViewModelProtocol: AnyObject {
    func loadData(completion: (() -> ())?)
    var movieModels: [MovieModel] { get }
    var cellViewModel: MovieListCellViewModel { get }
}

class MovieListViewModel: MovieListViewModelProtocol {
    private(set) var movieModels = [MovieModel]()
    
    private weak var delegate: MovieListViewProtocol?
    private let service: MovieServiceProtocol
    let cellViewModel = MovieListCellViewModel()
    
    init(service: MovieServiceProtocol, delegate: MovieListViewProtocol) {
        self.service = service
        self.delegate = delegate
    }
    
    func loadData(completion: (() -> ())? = nil) {
        service.getList(for: "Hero") { [weak self] response in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let movieModels):
                strongSelf.movieModels = movieModels
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

