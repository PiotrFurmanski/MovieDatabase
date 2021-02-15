//
//  MovieListViewModel.swift
//  MovieDatabaseTests
//
//  Created by Piotr Furmanski on 15/02/2021.
//

import UIKit
@testable import MovieDatabase

class MovieListViewMock: ReloadViewProtocol {
    var reloadCalled = false
    var stopLoadingIndicatorCalled = false
    var startLoadingIndicatorCalled = false
    var error = ""
    
    func reload() {
        reloadCalled = true
    }
    
    func startLoadingIndicator() {
        startLoadingIndicatorCalled = true
    }
    
    func stopLoadingIndicator() {
        stopLoadingIndicatorCalled = true
    }
    
    func show(error: String) {
        self.error = error
    }
}
