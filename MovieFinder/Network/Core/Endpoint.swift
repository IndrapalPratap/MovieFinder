//
//  Endpoint.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 23/06/25.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    func request() -> URLRequest?
}

extension Endpoint {
    func request() -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL + path) else { return nil }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}
