//
//  CoreDataManagerTests.swift
//  MovieFinderTests
//
//  Created by Indrapal Pratap on 23/06/25.
//


import Foundation
import XCTest
import CoreData
@testable import MovieFinder

final class CoreDataManagerTests: XCTestCase {
    
    let coreDataManager = CoreDataManager.shared
    
    override func setUp() {
        super.setUp()
        clearAllFavorites()
    }
    
    private func clearAllFavorites() {
        let context = coreDataManager.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavouriteMovieEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(deleteRequest)
        try? context.save()
    }
    
    func test_saveMovie_and_fetchFavourites() {
        // Given
        let movie = MoviesModel(
            id: 101,
            title: "Batman Begins",
            overview: "Origin story of Batman",
            posterPath: "/batman.jpg",
            releaseDate: "2005-06-15",
            voteAverage: 8.2
        )
        
        // When
        coreDataManager.save(movie: movie)
        let favourites = coreDataManager.fetchFavourites()
        
        // Then
        let savedMovie = favourites.first(where: { $0.id == Int64(movie.id) })
        XCTAssertNotNil(savedMovie)
        XCTAssertEqual(savedMovie?.title, movie.title)
    }
    
    func test_deleteMovie_removesFromFavourites() {
        // Given
        let movie = MoviesModel(
            id: 102,
            title: "Superman Returns",
            overview: "The return of the hero",
            posterPath: "/superman.jpg",
            releaseDate: "2006-06-28",
            voteAverage: 6.1
        )
        coreDataManager.save(movie: movie)
        
        // Pre-check
        XCTAssertTrue(coreDataManager
            .fetchFavourites()
            .contains(where: { $0.id == Int64(movie.id) }))
        
        // When
        coreDataManager.delete(movieId: movie.id)
        
        // Then
        let favourites = coreDataManager.fetchFavourites()
        XCTAssertFalse(favourites.contains(where: { $0.id == Int64(movie.id) }))
    }
    
    func test_isFavourite_returnsTrueAfterSave() {
        // Given
        let movie = MoviesModel(
            id: 103,
            title: "Iron Man",
            overview: "Tony Stark builds a suit",
            posterPath: "/ironman.jpg",
            releaseDate: "2008-05-02",
            voteAverage: 7.9
        )
        
        // When
        coreDataManager.save(movie: movie)
        
        // Then
        XCTAssertTrue(coreDataManager.isFavourite(movieId: movie.id))
    }
    
    func test_isFavourite_returnsFalseAfterDelete() {
        // Given
        let movie = MoviesModel(
            id: 104,
            title: "Thor",
            overview: "The god of thunder",
            posterPath: "/thor.jpg",
            releaseDate: "2011-05-06",
            voteAverage: 7.0
        )
        coreDataManager.save(movie: movie)
        XCTAssertTrue(coreDataManager.isFavourite(movieId: movie.id))
        
        // When
        coreDataManager.delete(movieId: movie.id)
        
        // Then
        XCTAssertFalse(coreDataManager.isFavourite(movieId: movie.id))
    }
}
