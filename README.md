# FBLA Mobile App

A Flutter mobile application for FBLA (Future Business Leaders of America) members to connect, access documents, and get help.

## Features

- **Sign In**: Select your FBLA chapter to get started
- **Home Screen**: Quick access to app features and recent activity
- **Connect with Others**: Find members, join discussion forums, and form study groups
- **Chatbot Help**: Get assistance with FBLA-related questions
- **Important Documents**: Access competition guidelines, study materials, and forms
- **Profile**: Manage your account and chapter information

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (recommended IDE)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd fbla-mobile-app-dev
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point and authentication wrapper
└── screens/
    ├── sign_in_screen.dart   # Chapter selection and sign-in
    ├── main_app_screen.dart  # Bottom navigation bar container
    ├── home_screen.dart      # Home screen with quick actions
    ├── profile_screen.dart   # User profile and settings
    ├── connect_screen.dart   # Connect with other members
    ├── chatbot_screen.dart   # Chatbot help interface
    └── documents_screen.dart # FBLA documents access
```

## Screens

### Sign In Screen
Users select their FBLA chapter from a dropdown list of all US states and territories. The selection is saved locally using SharedPreferences.

### Main App Screen
Contains a bottom navigation bar with 5 tabs:
- **Home**: Dashboard with quick actions
- **Connect**: Connect with other FBLA members
- **Chatbot**: AI assistant for help
- **Documents**: Access important FBLA documents
- **Profile**: User profile and settings

## Dependencies

- `flutter`: SDK
- `shared_preferences`: For local storage of user preferences
- `cupertino_icons`: iOS-style icons

## Development

This app uses Material Design 3 and follows Flutter best practices. The app state is managed through SharedPreferences for persistence across app restarts.

## License

This project is for educational purposes.
