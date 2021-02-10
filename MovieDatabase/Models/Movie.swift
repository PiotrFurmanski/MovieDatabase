//
//  Movie.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 10/02/2021.
//

import Foundation

struct SearchResponseModel: Codable {
    let result: [MovieModel]
    
    private enum CodingKeys: String, CodingKey {
        case result = "Search"
    }
}

struct MovieModel: Codable {
    let title: String
    let year: String
    let imdbID: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
}
