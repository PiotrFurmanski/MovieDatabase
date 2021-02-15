//
//  MovieServiceMock.swift
//  MovieDatabaseTests
//
//  Created by Piotr Furmanski on 15/02/2021.
//

import Foundation
@testable import MovieDatabase

class MovieServiceMock: MovieServiceProtocol {
    enum CustomError: Error {
        case someError
    }
    
    var isErrorOccurs = false
    
    func getList(for title: String, page: Int,
                 completion: @escaping (Result<SearchResponseModel, Error>) -> Void) {
        if isErrorOccurs {
            completion(.failure(CustomError.someError))
            return
        }
        
        if page == 2 {
            completion(.success(SearchResponseModel(result: [MovieModel(title: "test3",
                                                                        year: "1990",
                                                                        imdbID: "3",
                                                                        poster: "")],
                                                    totalResults: "3")))
            return
        }
        completion(.success(SearchResponseModel(result: [MovieModel(title: "test1",
                                                                    year: "1990",
                                                                    imdbID: "1",
                                                                    poster: ""),
                                                         MovieModel(title: "test2",
                                                                    year: "1991",
                                                                    imdbID: "2",
                                                                    poster: "2")],
                                                totalResults: "3")))
    }
    
    func getDetails(for id: String, completion: @escaping (Result<MovieDetailsModel, Error>) -> Void) {
        isErrorOccurs ? completion(.failure(CustomError.someError)) :
            completion(.success(MovieDetailsModel(title: "test", year: "1990", rated: "18", date: "1990",
                                                  runtime: "2h", genre: "horror", imdbID: "2",
                                                  director: "Smith", writer: "John", actors: "Pitt",
                                                  plot: "Some plot", language: "English", country: "USA",
                                                  poster: "", awards: "",
                                                  ratings: [Rating(source: "IMDB", value: "7,2")],
                                                  imdbVotes: "500", imdbRating: "7,2", metascore: "",
                                                  boxOffice: "", production: "")))
    }
    
}
