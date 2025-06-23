//
//  MovieDetailViewModelTests.swift
//  MovieFinderTests
//
//  Created by Indrapal Pratap on 24/06/25.
//

import Foundation
import XCTest
@testable import MovieFinder

final class MovieDetailViewModelTests: XCTestCase {

    func test_getters_returnExpectedValues() {
        // Given
        let movie = MoviesModel(
            id: 1,
            title: "Inception",
            overview: "A mind-bending thriller",
            posterPath: "/inception.jpg",
            releaseDate: "2010-07-16",
            voteAverage: 8.8
        )
        let viewModel = MovieDetailViewModel(movie: movie)

        // Then
        XCTAssertEqual(viewModel.getTitle(), "Inception")
        XCTAssertEqual(viewModel.getOverview(), "A mind-bending thriller")
        XCTAssertEqual(viewModel.getReleaseDate(), "2010-07-16")
        XCTAssertEqual(viewModel.getVoteAverage(), "8.8")
        XCTAssertEqual(viewModel.getPosterURL()?.absoluteString, "\(API.imageBaseURL)/inception.jpg")
    }
}

