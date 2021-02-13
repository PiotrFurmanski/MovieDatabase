//
//  MovieListViewModel.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 11/02/2021.
//

import UIKit

protocol ReloadViewProtocol: AnyObject {
    func reload()
    func startLoadingIndicator()
    func stopLoadingIndicator()
    func show(error: String)
}

protocol MovieListViewModelProtocol: AnyObject {
    func loadData(for title: String, completion: (() -> ())?)
    var movieModels: [MovieModel] { get }
    var cellViewModel: MovieListCellViewModel { get }
}

class MovieListViewModel: MovieListViewModelProtocol {
    private(set) var movieModels = [MovieModel]()
    
    private weak var delegate: ReloadViewProtocol?
    private let service: MovieServiceProtocol
    let cellViewModel = MovieListCellViewModel()
    
    init(service: MovieServiceProtocol, delegate: ReloadViewProtocol) {
        self.service = service
        self.delegate = delegate
    }
    
    func loadData(for title: String, completion: (() -> ())? = nil) {
        guard !title.isEmpty else { return }
        delegate?.startLoadingIndicator()
        service.getList(for: title) { [weak self] response in
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

