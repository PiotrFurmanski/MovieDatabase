//
//  MovieDetailsViewModelTests.swift
//  MovieDatabaseTests
//
//  Created by Piotr Furmanski on 15/02/2021.
//

import XCTest
@testable import MovieDatabase

class MovieDetailsViewModelTests: XCTestCase {
    
    private struct Constants {
        static let timeout = 5.0
        static let description = "Loading end"
        static let movieId = "movieId"
    }
    
    let service = MovieServiceMock()
    let delegate = MovieListViewMock()
    var viewModel: MovieDetailsViewModel!

    override func setUpWithError() throws {
        viewModel = MovieDetailsViewModel(service: service, delegate: delegate)
    }

    func testLoadDataNoError() {
        let expect = expectation(description: Constants.description)
        viewModel.loadData(for: Constants.movieId) {
            expect.fulfill()
        }
        waitForExpectations(timeout: Constants.timeout, handler: nil)
        XCTAssertNotNil(viewModel.movieDetailsModel)
        XCTAssertTrue(delegate.stopLoadingIndicatorCalled)
        XCTAssertTrue(delegate.reloadCalled)
    }
    
    func testLoadDataError() {
        let expect = expectation(description: Constants.description)
        service.isErrorOccurs = true
        viewModel.loadData(for: Constants.movieId) {
            expect.fulfill()
        }
        waitForExpectations(timeout: Constants.timeout, handler: nil)
        XCTAssertNil(viewModel.movieDetailsModel)
        XCTAssertTrue(delegate.stopLoadingIndicatorCalled)
        XCTAssertFalse(delegate.error.isEmpty)
    }

}
