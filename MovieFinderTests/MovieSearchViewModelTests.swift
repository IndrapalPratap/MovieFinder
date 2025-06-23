//
//  MovieSearchViewModelTests.swift
//  MovieFinderTests
//
//  Created by Indrapal Pratap on 23/06/25.
//
import Foundation
import XCTest

@testable import MovieFinder

class MovieSearchViewModelTests: XCTestCase {
    
    func test_searchSuccess_updatesMovies() {
        let mockService = MockNetworkService()
        mockService.mockMovies = [
            MoviesModel(id: 1,
                        title: "Inception",
                        overview: "Mind-bending movie.",
                        posterPath: "/image1.jpg",
                        releaseDate: "2010-07-16",
                        voteAverage: 8.8)
        ]
        let viewModel = MovieSearchViewModel(service: MovieDataService(networkService: mockService))
        let expectation = self.expectation(description: "Movies fetched")
        
        viewModel.onUpdate = {
            XCTAssertEqual(viewModel.movies.count, 1)
            XCTAssertEqual(viewModel.movies.first?.title, "Inception")
            expectation.fulfill()
        }
        
        viewModel.search(query: "Inception")
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_searchFailure_triggersOnError() {
        let mockService = MockNetworkService()
        mockService.shouldReturnError = true
        let viewModel = MovieSearchViewModel(service: MovieDataService(networkService: mockService))
        let expectation = self.expectation(description: "Error triggered")
        
        viewModel.onError = { (message: String) in
            XCTAssertEqual(message, NetworkError.decodingError.getMessage())
            expectation.fulfill()
        }
        
        viewModel.search(query: "Test")
        wait(for: [expectation], timeout: 1.0)
    }
}

