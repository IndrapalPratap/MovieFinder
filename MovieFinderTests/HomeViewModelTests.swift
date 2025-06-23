//
//  HomeViewModelTests.swift
//  MovieFinderTests
//
//  Created by Indrapal Pratap on 23/06/25.
//

import Foundation
import XCTest
@testable import MovieFinder

final class HomeViewModelTests: XCTestCase {
    
    // MARK: - Mock Service
    class MockHomeService: MovieDataServiceProtocol {
        var shouldReturnError = false
        var moviesToReturn: [MoviesModel] = []
        
        func fetchMovies(for query: String, completion: @escaping (Result<[MoviesModel], NetworkError>) -> Void) {
            if shouldReturnError {
                completion(.failure(.decodingError))
            } else {
                completion(.success(moviesToReturn))
            }
        }
    }
    
    // MARK: - Test: Success Case
    func test_fetchMovies_success_updatesMovies() {
        // Given
        let mockService = MockHomeService()
        mockService.moviesToReturn = [
            MoviesModel(id: 1,
                        title: "Iron Man",
                        overview: "Tony Stark builds a suit.",
                        posterPath: "/iron.jpg",
                        releaseDate: "2008-05-02",
                        voteAverage: 7.9)
        ]
        let viewModel = HomeViewModel(dataService: mockService)
        let expectation = expectation(description: "Movies updated")
        
        viewModel.onMoviesUpdated = {
            XCTAssertEqual(viewModel.numberOfMovies(), 1)
            XCTAssertEqual(viewModel.movie(at: 0).title, "Iron Man")
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchMovies()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Test: Failure Case
    func test_fetchMovies_failure_triggersOnError() {
        // Given
        let mockService = MockHomeService()
        mockService.shouldReturnError = true
        
        let viewModel = HomeViewModel(dataService: mockService)
        let expectation = expectation(description: "Error handler called")
        
        viewModel.onError = { errorMessage in
            // 🔍 Make sure it contains the correct error string as returned by your ViewModel
            XCTAssertEqual(errorMessage, "Failed to load: Failed to decode response")
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchMovies()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}
