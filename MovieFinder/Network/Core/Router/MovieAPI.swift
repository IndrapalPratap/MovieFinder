//
//  MovieAPI.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 23/06/25.
//

import Foundation

enum MovieAPI: Endpoint {
    case searchMovies(query: String)
    
    static func search(query: String) -> MovieAPI {
        return .searchMovies(query: query)
    }
    
    var baseURL: String { "https://api.themoviedb.org/3" }
    
    var path: String {
        switch self {
        case .searchMovies:
            return "/search/movie"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchMovies(let query):
            return [
                URLQueryItem(name: "api_key", value: Constants.apiKey), // Use a constant
                URLQueryItem(name: "query", value: query)
            ]
        }
    }
}
