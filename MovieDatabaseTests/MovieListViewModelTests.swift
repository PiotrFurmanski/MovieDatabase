//
//  MovieDatabaseTests.swift
//  MovieDatabaseTests
//
//  Created by Piotr Furmanski on 10/02/2021.
//

import XCTest
@testable import MovieDatabase

class MovieListViewModelTests: XCTestCase {
    
    private struct Constants {
        static let timeout = 5.0
        static let description = "Loading end"
        static let searchKey = "test"
    }
    
    let service = MovieServiceMock()
    let delegate = MovieListViewMock()
    var viewModel: MovieListViewModel!

    override func setUpWithError() throws {
        viewModel = MovieListViewModel(service: service, delegate: delegate)
    }

    func testLoadDataNoError() {
        let expect = expectation(description: Constants.description)
        viewModel.loadData(for: Constants.searchKey) {
            expect.fulfill()
        }
        waitForExpectations(timeout: Constants.timeout, handler: nil)
        XCTAssertEqual(viewModel.movieModels.count, 2)
        XCTAssertTrue(delegate.startLoadingIndicatorCalled)
        XCTAssertTrue(delegate.stopLoadingIndicatorCalled)
        XCTAssertTrue(delegate.reloadCalled)
    }
    
    func testLoadDataEmptyKey() {
        let expect = expectation(description: Constants.description)
        viewModel.loadData(for: "") {
            expect.fulfill()
        }
        waitForExpectations(timeout: Constants.timeout, handler: nil)
        XCTAssertEqual(viewModel.movieModels.count, 0)
        XCTAssertFalse(delegate.startLoadingIndicatorCalled)
        XCTAssertFalse(delegate.stopLoadingIndicatorCalled)
        XCTAssertFalse(delegate.reloadCalled)
    }
    
    func testLoadDataError() {
        let expect = expectation(description: Constants.description)
        service.isErrorOccurs = true
        viewModel.loadData(for: Constants.searchKey) {
            expect.fulfill()
        }
        waitForExpectations(timeout: Constants.timeout, handler: nil)
        XCTAssertEqual(viewModel.movieModels.count, 0)
        XCTAssertTrue(delegate.startLoadingIndicatorCalled)
        XCTAssertTrue(delegate.stopLoadingIndicatorCalled)
        XCTAssertFalse(delegate.error.isEmpty)
    }
    
    func testLoadMoreData() {
        let expect = expectation(description: Constants.description)
        let expect2 = expectation(description: Constants.description)
        let expect3 = expectation(description: Constants.description)
        
        viewModel.loadData(for: Constants.searchKey) {
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: Constants.timeout)
        XCTAssertEqual(viewModel.movieModels.count, 2)
        
        viewModel.loadMoreData(for: Constants.searchKey) {
            expect2.fulfill()
        }
        
        wait(for: [expect2], timeout: Constants.timeout)
        XCTAssertEqual(viewModel.movieModels.count, 3)
        XCTAssertTrue(delegate.startLoadingIndicatorCalled)
        
        delegate.startLoadingIndicatorCalled = false
        viewModel.loadMoreData(for: Constants.searchKey) {
            expect3.fulfill()
        }
        
        wait(for: [expect3], timeout: Constants.timeout)
        XCTAssertFalse(delegate.startLoadingIndicatorCalled)
    }

}
