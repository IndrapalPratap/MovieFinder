//
//  MoviesModel.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 20/06/25.
//

import Foundation

struct MovieSearchResponse: Codable {
    let results: [MoviesModel]
}

struct MoviesModel: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
