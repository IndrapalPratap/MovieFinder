//
//  SearchViewModel.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 20/06/25.
//

import Foundation

class MovieSearchViewModel {

    private let service: MovieDataService
    var movies: [MoviesModel] = []

    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    // Dependency injection for service (default or testable)
    init(service: MovieDataService = MovieDataService()) {
        self.service = service
    }

    func search(query: String) {
        service.fetchMovies(for: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.onUpdate?()
            case .failure(let error):
                self?.onError?(error.getMessage())
            }
        }
    }

    func numberOfMovies() -> Int {
        return movies.count
    }

    func movie(at index: Int) -> MoviesModel {
        return movies[index]
    }
}
