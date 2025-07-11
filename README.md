# CampKeeper - Flutter Campsite Platform

A scalable campsite platform built with Flutter, following clean architecture principles and using Riverpod for state management. This app allows users to browse campsites, filter them by various attributes, and view them on a map with clustering functionality.

## Features

- 📱 **Cross-platform**: Runs on Web, iOS, and Android
- 🏗️ **Clean Architecture**: Follows clean architecture principles with clear separation of concerns
- 🔄 **State Management**: Uses Riverpod for efficient state management
- 🗺️ **Interactive Map**: Google Maps integration with clustering for better performance
- 🔍 **Advanced Filtering**: Filter campsites by country, language, price, and amenities
- 🎨 **Modern UI/UX**: Material Design 3 with collapsible app bar, improved icons, and responsive design
- 🧪 **Unit Tests**: Comprehensive unit tests for core functionality
- 🌐 **API Integration**: Fetches real campsite data from external API

## Architecture

The app follows Clean Architecture principles with the following layers:

```
lib/
├── core/                     # Core functionality
│   ├── constants/           # API constants
│   ├── error/              # Error handling
│   └── network/            # Network utilities
├── features/
│   └── campsites/
│       ├── data/           # Data layer
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/         # Domain layer
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/   # Presentation layer
│           ├── pages/
│           ├── providers/
│           └── widgets/
└── main.dart
```

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- OpenStreetMap

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd campkeeper_riverpod
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build
   ```

4. **Maps Configuration**
   
   The app uses OpenStreetMap which is free and doesn't require API keys. No additional configuration needed for maps.

5. **Run the app**
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile
   flutter run
   ```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## API Integration

The app fetches campsite data from:
```
https://62ed0389a785760e67622eb2.mockapi.io/spots/v1/campsites
```

### Data Model

Each campsite contains:
- `id`: Unique identifier
- `label`: Descriptive name
- `geoLocation`: Coordinates (lat, long)
- `isCloseToWater`: Boolean for water proximity
- `isCampFireAllowed`: Boolean for campfire permission
- `hostLanguages`: Array of host languages
- `pricePerNight`: Price in euros
- `photo`: Image URL
- `createdAt`: Creation timestamp
- `suitableFor`: Array of suitability tags

## Key Features Implementation

### 1. Clean Architecture
- **Domain Layer**: Contains business logic and entities
- **Data Layer**: Handles API calls and data transformation
- **Presentation Layer**: UI components and state management

### 2. State Management with Riverpod
- Providers for dependency injection
- StateNotifier for complex state management
- Automatic state updates and rebuilds

### 3. Error Handling
- Custom failure classes
- Network error handling
- User-friendly error messages

### 4. Data Validation
- Invalid coordinate fixing (generates valid European coordinates)
- Null safety throughout the app
- Input validation for filters

### 5. Performance Optimizations
- Image caching with `cached_network_image`
- Map clustering for better performance
- Efficient list rendering with `ListView.builder`
- Shimmer loading effects

## Deployment

### Web Deployment (GitHub Pages)

1. **Build for web**
   ```bash
   flutter build web --release
   ```

2. **Deploy to GitHub Pages**
   - Push the `build/web` folder to your repository
   - Enable GitHub Pages in repository settings
   - Set source to the appropriate branch/folder

### Mobile Deployment

**Android:**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## Dependencies

### Main Dependencies
- `flutter_riverpod`: State management
- `dio`: HTTP client
- `flutter_map`: OpenStreetMap integration
- `cached_network_image`: Image caching
- `json_annotation`: JSON serialization

### Development Dependencies
- `build_runner`: Code generation
- `json_serializable`: JSON serialization
- `mockito`: Testing mocks
- `flutter_test`: Testing framework

## License

This project is licensed under the MIT License - see the LICENSE file for details.