//
//  MockNetworkService.swift
//  MovieFinderTests
//
//  Created by Indrapal Pratap on 23/06/25.
//

import Foundation

@testable import MovieFinder

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockMovies: [MoviesModel] = []
    
    func request<T>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        if shouldReturnError {
            completion(.failure(.decodingError))
        } else {
            let response = MovieSearchResponse(results: mockMovies)
            if let casted = response as? T {
                completion(.success(casted))
            } else {
                completion(.failure(.decodingError))
            }
        }
    }
}
