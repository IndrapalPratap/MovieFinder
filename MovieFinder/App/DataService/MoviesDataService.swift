//
//  MoviesDataService.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 20/06/25.
//

import Foundation

// MovieDataService.swift
import Foundation

class MovieDataService: MovieDataServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchMovies(for query: String, completion: @escaping (Result<[MoviesModel], NetworkError>) -> Void) {
        networkService.request(MovieAPI.searchMovies(query: query)) { (result: Result<MovieSearchResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


