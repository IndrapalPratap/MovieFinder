//
//  MovieDataServiceProtocol.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 23/06/25.
//

import Foundation


protocol MovieDataServiceProtocol {
    func fetchMovies(for query: String, completion: @escaping (Result<[MoviesModel], NetworkError>) -> Void)
}

