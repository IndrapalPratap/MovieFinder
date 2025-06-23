//
//  HomeViewModel.swift
//  YouMovies
//
//  Created by Indrapal Pratap on 18/06/25.
//

import Foundation

class HomeViewModel {
    
    private(set) var movies: [MoviesModel] = [] {
        didSet { onMoviesUpdated?() }
    }
    
    private let dataService: MovieDataServiceProtocol
    
    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(dataService: MovieDataServiceProtocol = MovieDataService()) {
        self.dataService = dataService
    }
    
    func fetchMovies() {
        dataService.fetchMovies(for: DefaultSearch.homeQuery) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                self?.onError?("\(ErrorMessage.fetchFailedPrefix)\(error.getMessage())")
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
