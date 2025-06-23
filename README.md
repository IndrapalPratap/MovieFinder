
# 🎬 MovieFinder App

MovieFinder is a sample iOS application that allows users to search for movies, view detailed information, and save favorites locally. This project is built using UIKit and follows the **MVVM architecture** with a modular and testable codebase.

---

## 🚀 Features

- 🔍 Real-time movie search with debounced input
- 📄 Movie detail screen with poster, description, and rating
- ❤️ Add/Remove from favorites (locally saved with Core Data)
- 🧪 Unit tested services, view models, and persistence logic
- 🎨 Clean and intuitive UI with gradient splash screen

---

## 🔧 Project Architecture

**MVVM (Model-View-ViewModel)** was used to separate concerns:
- `Model`: Represents movie and API data.
- `ViewModel`: Business logic, formatting, and view state.
- `View/Controller`: Displays the UI and binds to ViewModel.

---

## 🌐 API Integration

- Integrated with **The Movie Database (TMDB) API** using `URLSession`.
- Modular `NetworkService` handles all HTTP calls.
- A generic `Endpoint` system builds and maintains API routes.
- Decoding handled with `Codable`, including custom key mapping.

### 🔑 Assumptions:
- API key is valid and included in the build.
- The poster image is optional — a placeholder is shown if missing.

---

## 💾 Data Persistence (Favorites)

- Implemented using **Core Data** to persist favorite movies.
- A singleton `CoreDataManager` handles saving, deleting, and fetching.
- Prevents duplicate favorites.
- Includes unit tests for all Core Data operations.

---

## ✅ Validation & Error Handling

- Basic validation: Movie search input is trimmed and validated before triggering API calls.
- Error types are encapsulated in a custom `NetworkError` enum.
- User-friendly messages are returned via `.getMessage()` function.
- Handles no-data, decoding, and invalid URL scenarios gracefully.

---

## 🧪 Running Unit Tests

### 📌 Instructions:

1. Open `MovieFinder.xcodeproj` in Xcode.
2. Select the **MovieFinder** scheme.
3. Press **Command + U** to run all tests.

### 🧪 Test Coverage:

- 60%+ overall coverage
- Unit tests for:
  - ViewModels (Home, Search, Detail)
  - CoreDataManager
  - Network services
- UI test for app launch and basic interactions

---

## 👨‍💻 Developer Notes

- Debounced search input with 1-second delay for efficient API use.
- Reusable extensions for colors, labels, and utilities.
- Designed with performance and modularity in mind.

---

## 📬 Contact

If you have any questions or suggestions, feel free to reach out. Thank you for reviewing MovieFinder! 😊
