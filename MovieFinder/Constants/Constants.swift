//
//  Constants.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 21/06/25.
//

import Foundation

import Foundation

// TabBar
struct StoryboardName {
    static let home = "Home"
    static let search = "Search"
    static let favourite = "Favourite"
}

struct ViewControllerID {
    static let homeVC = "HomeViewController"
    static let searchVC = "SearchViewController"
    static let favouriteVC = "FavouriteViewController"
}

struct TabBarIcon {
    static let home = "homeicon8"
    static let search = "mgnifying8b"
    static let favourite = "heartIcon"
}

struct TabBarTitle {
    static let home = "Home"
    static let search = "Search Movies"
    static let favourite = "Favourite"
}

// Favourite cell
struct SystemIcon {
    static let closeCircle = "xmark.circle.fill"
    static let heartFilled = "heart.fill"
    static let heart = "heart"
}

struct API {
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static let baseSearchMovieURL = "https://api.themoviedb.org/3/search/movie"
    static let imageBaseSmallURL = "https://image.tmdb.org/t/p/w200"
}

struct AssetName {
    static let placeholder = "placeholder"
    static let defaultPoster = "defaulticon"
}

// HomeTableViewCell
struct LabelText {
    static let releasePrefix = "Release: "
    static let notAvailable = "N/A"
    static let releaseDatePrefix = "Release Date: "
    static let ratingPrefix = "Rating: "
}

struct Symbol {
    static let star = "⭐️ "
}

// HomeViewController
struct AlertText {
    static let errorTitle = "Error"
    static let okButton = "OK"
}

// HomeViewModel
struct DefaultSearch {
    static let homeQuery = "Avengers"
}

struct ErrorMessage {
    static let fetchFailedPrefix = "Failed to load: "
    static let missingAPIKey = "Missing TMDB_API_KEY in Info.plist"
    static let emptySearchQuery = "Please enter a search query"
    static let searchFailedPrefix = "Failed to fetch movies: "
}

//MoviesDataService
struct InfoPlistKey {
    static let tmdbAPIKey = "TMDB_API_KEY"
}

// MovieDetailViewController
struct ButtonText {
    static let empty = ""
}

struct PlaceholderText {
    static let notAvailable = "N/A"
    static let noDescription = "No description available"
    static let searchMovieName = "Search by movie name"
    
}

struct EmptyStateText {
    static let noResults = "No results found."
}

// SearchViewModel
struct ErrorKeyword {
    static let cancelled = "cancelled"
}

enum Constants {
    static let apiKey: String = {
        guard let key = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return key
    }()
}

