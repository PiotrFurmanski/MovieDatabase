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
    let imdbID: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
}

struct Rating: Codable {
    
}

"Title":"Captain Marvel",
"Year":"2019",
"Rated":"PG-13",
"Released":"08 Mar 2019",
"Runtime":"123 min",
"Genre":"Action, Adventure, Sci-Fi",
"Director":"Anna Boden, Ryan Fleck",
"Writer":"Anna Boden (screenplay by), Ryan Fleck (screenplay by), Geneva Robertson-Dworet (screenplay by), Nicole Perlman (story by), Meg LeFauve (story by), Anna Boden (story by), Ryan Fleck (story by), Geneva Robertson-Dworet (story by)",
"Actors":"Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Jude Law",
"Plot":"Carol Danvers becomes one of the universe's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.",
"Language":"English",
"Country":"USA, Australia",
"Awards":"8 wins & 48 nominations.",
"Poster":"https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg",
"Ratings":[
{
"Source":"Internet Movie Database",
"Value":"6.9/10"
},
{
"Source":"Rotten Tomatoes",
"Value":"79%"
},
{
"Source":"Metacritic",
"Value":"64/100"
}
],
"Metascore":"64",
"imdbRating":"6.9",
"imdbVotes":"437,802",
"imdbID":"tt4154664",
"Type":"movie",
"DVD":"N/A",
"BoxOffice":"$426,829,839",
"Production":"Marvel Studios",
"Website":"N/A",
"Response":"True"
