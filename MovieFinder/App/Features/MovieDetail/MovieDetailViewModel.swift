//
//  MovieDetailViewModel.swift
//  YouMovies
//
//  Created by Indrapal Pratap on 18/06/25.
//

import Foundation

class MovieDetailViewModel {
    
    private let movie: MoviesModel
    
    init(movie: MoviesModel) {
        self.movie = movie
    }
    
    func getTitle() -> String {
        return movie.title
    }
    
    func getReleaseDate() -> String {
        return movie.releaseDate ?? PlaceholderText.notAvailable
    }
    
    func getOverview() -> String {
        return movie.overview
    }
    
    func getVoteAverage() -> String {
        if let avg = movie.voteAverage {
            return String(format: "%.1f", avg)
        }
        return PlaceholderText.notAvailable
    }
    
    func getPosterURL() -> URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "\(API.imageBaseURL)\(path)")
    }
}
