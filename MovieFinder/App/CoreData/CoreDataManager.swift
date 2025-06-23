//
//  CoreDataManager.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 21/06/25.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(movie: MoviesModel) {
        let fav = FavouriteMovieEntity(context: context)
        fav.id = Int64(movie.id)
        fav.title = movie.title
        fav.releaseDate = movie.releaseDate ?? ""
        fav.posterPath = movie.posterPath ?? ""
        fav.overview = movie.overview
        fav.voteAverage = movie.voteAverage ?? 0.0
        try? context.save()
    }
    
    func fetchFavourites() -> [FavouriteMovieEntity] {
        let request: NSFetchRequest<FavouriteMovieEntity> = FavouriteMovieEntity.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func delete(movieId: Int) {
        let request: NSFetchRequest<FavouriteMovieEntity> = FavouriteMovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movieId)
        if let results = try? context.fetch(request),
           let movie = results.first {
            context.delete(movie)
            try? context.save()
        }
    }
    
    func isFavourite(movieId: Int) -> Bool {
        let request: NSFetchRequest<FavouriteMovieEntity> = FavouriteMovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movieId)
        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }
}
