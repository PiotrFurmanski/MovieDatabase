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
    func loadMoreData(for title: String, completion: (() -> ())?)
    var movieModels: [MovieModel] { get }
    var cellViewModel: MovieListCellViewModel { get }
}

class MovieListViewModel: MovieListViewModelProtocol {
    private struct Contants {
        static let resultsPerPage = 10.0
    }
    private(set) var movieModels = [MovieModel]()
    private(set) var totalMovies = 0
    
    private weak var delegate: ReloadViewProtocol?
    private let service: MovieServiceProtocol
    let cellViewModel = MovieListCellViewModel()
    
    init(service: MovieServiceProtocol, delegate: ReloadViewProtocol) {
        self.service = service
        self.delegate = delegate
    }
    
    func loadMoreData(for title: String, completion: (() -> ())? = nil) {
        guard !title.isEmpty else { return }
        guard movieModels.count < totalMovies || totalMovies == 0 else { return }
        loadList(for: title, completion: completion)
    }
    
    func loadData(for title: String, completion: (() -> ())? = nil) {
        guard !title.isEmpty else { return }
        movieModels.removeAll()
        totalMovies = 0
        loadList(for: title, completion: completion)
    }
    
    private func loadList(for title: String, completion: (() -> ())?) {
        delegate?.startLoadingIndicator()
        let page = ceil(Double(movieModels.count) / Contants.resultsPerPage) + 1
        service.getList(for: title, page: Int(page)) { [weak self] response in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let response):
                strongSelf.movieModels.append(contentsOf: response.result)
                strongSelf.totalMovies = Int(response.totalResults) ?? 0
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

