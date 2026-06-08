# Rick & Morty Flutter App

A Flutter application that displays characters from the Rick and Morty universe.  
The app supports offline caching, favorites, search, Firebase Analytics, and theme switching.

---

## features
- Fetch characters from the Rick & Morty API
- View character name, image, species, and status
- Tap to open detailed character screen

## favourites
- Mark/unmark characters as favorites
- View all favorite characters in a separate screen
- Favorites stored locally using Hive

### offline cache
- Characters cached locally with Hive
- App falls back to cache when API fails

### firebase analytics
Tracked events:
- app_started
- character_opened
- favorite_toggled
- search_used

---

## technologies

- Flutter
- Dart
- Hive (local storage)
- Firebase Analytics
- HTTP API integration

---

## Project Structure

lib/
├── features/
│ └── characters/
│ ├── presentation/
│ │ ├── character_list_screen.dart
│ │ ├── character_detail_screen.dart
│ │ ├── favorites_screen.dart
│ │ └── settings_screen.dart
│ ├── data/
│ │ ├── character_api.dart
│ │ ├── character_cache.dart
│ │ ├── favs_cache.dart
│ │ └── character.dart
│
├── app_theme.dart
├── main.dart
