//
//  MovieDetails.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 10/02/2021.
//

import Foundation

struct MovieDetailsModel: Codable {
    let title: String
    let year: String
    let rated: String
    let date: String
    let runtime: String
    let genre: String
    let imdbID: String
    let director: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let poster: String
    let awards: String
    let ratings: [Rating]
    let imdbVotes: String
    let imdbRating: String
    let metascore: String
    let boxOffice: String
    let production: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case date = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case imdbID
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case poster = "Poster"
        case awards = "Awards"
        case ratings = "Ratings"
        case imdbVotes
        case imdbRating
        case metascore = "Metascore"
        case boxOffice = "BoxOffice"
        case production = "Production"
    }
}

struct Rating: Codable {
    let source: String
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
