# Cats SwiftUI App - MVVM-C
#### _Using The Cat API [(https://thecatapi.com/)](https://thecatapi.com/)_
__Author: Evens Taian__

This project implements the __MVVM-C__ (Model-View-ViewModel-Coordinator) architectural pattern, enabling clean code maintenance, readability, well-defined responsibilities, and testability. The application was built following SOLID principles:

- Single Responsibility Principle
- Open-Closed Principle  
- Liskov Substitution Principle
- Interface Segregation Principle
- Dependency Inversion Principle

View development method: SwiftUI

### Project Architecture

The project is structured using MVVM-C pattern with the following components:

- **View**: SwiftUI views responsible for UI elements and user interactions
- **ViewModel**: Handles business logic and data transformation
- **Model**: Represents data structures (FeedData, Breed)
- **Coordinator**: Manages navigation flow between views
- **Service**: Handles API communication

### Key Features

- Cat breeds list with infinite scroll
- Pull to refresh functionality with custom paw print animation
- Detailed breed information view
- Support for both portrait and landscape orientations
- Network error handling
- Mock data support for testing

### SwiftUI Implementation

The project leverages SwiftUI's modern features:

- Declarative UI syntax
- Reactive data binding with @Published and @ObservedObject
- Custom view modifiers and extensions
- Reusable components
- Native navigation

### Dependency Injection & Abstractions

The project uses protocol-oriented programming and dependency injection. This approach:

- Enables easier testing through mock objects
- Reduces coupling between components
- Improves code maintainability
- Follows SOLID principles

### Network Layer

The networking layer is built with:
- Protocol-based API requests
- Error handling with custom NetworkErrors
- Mock data support for testing
- Completion handler based async operations

### Testing Support

The project includes:
- Mock API implementation for testing
- Unit tests for ViewModels
- UI tests for main user flows
- Mock services for isolated testing
- Protocol-based dependencies for easy mocking

### Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+

### Installation

1. Clone the repository
2. Open Cats SUI.xcodeproj
3. Build and run the project

### Credits

This project uses [The Cat API](https://thecatapi.com/) for cat breeds data.
