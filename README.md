# LMU Students App

[![Download App](https://img.shields.io/badge/Download-App-287FF4?style=flat)](https://lmu-app.lmu-dev.org/)
[![Website](https://img.shields.io/badge/Visit-Website-0B7E32?style=flat)](https://www.lmu-dev.org/)
[![Instagram](https://img.shields.io/badge/Follow-Instagram-FF1B64?style=flat)](https://www.instagram.com/lmu.developers/)
[![LinkedIn](https://img.shields.io/badge/Follow-LinkedIn-0077B5?style=flat)](https://www.linkedin.com/company/lmu-dev/)
![GitHub License](https://img.shields.io/github/license/lmu-devs/lmu_app_client?color=F1F1F1&style=flat&label=License)

Your Companion for Study and Campus Life at LMU Munich.

Developed by students for students, the LMU Students app provides a platform for the LMU community to easily access information about their study as well as LMU services, making university life more convenient and enjoyable.

Supported Platforms: Android, iOS

</br>

![app_preview](https://github.com/user-attachments/assets/6f49c9d5-f537-4e3a-87dd-8c5055f72351)

## Table of Contents

- [About](#about)
- [Features](#features)
- [Development](#development)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [License](#license)

</br>

## About

The app is developed and managed by LMU Developers, an official student organization at Ludwig Maximilian University of Munich. If you have any inquiries, visit our [website](https://www.lmu-dev.org/) or contact us via [email](mailto:contact@lmu-dev.org).

</br>

## Features

- [x] **Mensa**: Set favourite canteens, find current dishes, and filter for food preferences
- [x] **Roomfinder**: Locate buildings and rooms effortlessly
- [x] **University Cinema**: Browse upcoming movies and add them to your watchlist
- [x] **University Sport**: Explore available courses
- [x] **Timeline**: Stay up to date on events and deadlines
- [x] **Quicklinks**: Pin your most-used university services for instant access
- [x] **Student Benefits**: Find discounts and offers
- [x] **Wishlist**: Vote on upcoming features, suggest ideas, and become a part of the development
- [x] **Feedback**: Give in-app feedback that gets directly to the developers

</br>

## Development

### Prerequisites

Before you can start with Flutter, ensure you have the following installed:

1. **Flutter SDK 3.32.0**: Download and install Flutter from the official [Flutter website](https://flutter.dev/docs/get-started/install).
[Download MacOS ARM](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.32.0-stable.zip), [Download Windows x64](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.32.0-stable.zip)
2. **Dart SDK**: This comes bundled with the Flutter SDK.
3. **Android Studio** or **Visual Studio Code**: These are the recommended IDEs for Flutter development.
4. **Android SDK**: Necessary for building and running Android apps.
5. **Xcode**: Required for building and running iOS apps (macOS only).

</br>

Check if required tools are installed:
```sh
flutter doctor
```

Check running emulators, connected devices, and web browsers for development and testing:
```sh
flutter devices
```

</br>

### Installation

Follow these steps to set up your development environment:

1. **Set Up Your Editor**:
    - **Visual Studio Code**: Install the Flutter and Dart plugins from the extensions marketplace.
    - **Android Studio**: Install the Flutter and Dart plugins from the plugins section.

2. **Clone the Repository**:
    ```sh
    git clone https://github.com/lmu-devs/lmu_app_client.git
    cd lmu_app_client
    ```

3. **Install Dependencies**:
    Run the following command to fetch the dependencies listed in your `pubspec.yaml` file.
    ```sh
    flutter pub get
    ```

4. **Generate Localizations**:
    To generate German and English translations from the `l10n` folder, run the following command.
    ```sh
    make localizations
    ```

5. **Setup .env File**:
    Create a `.env` file with the following command and get the Api-Keys from our Notion Space.
   ```sh
   cp .env-example .env
   ```

</br>

6. **Using Flutter Version Management (FVM) - optional Step**
This project uses [FVM (Flutter Version Management)](https://fvm.app/) to ensure a consistent Flutter SDK version across all team members and environments.
FVM allows us to configure and isolate the Flutter SDK version per project, which is especially useful when working on multiple projects (on your computer) that may require different Flutter or Dart versions.
If you do not have multible Flutter projects on your Computer or all are using the same Flutter SDk Version all the time you might not need FVM.

Why use FVM?
- Guarantees everyone uses the same SDK version defined in .fvmrc.
- Avoids conflicts switching between projects with different Flutter versions.
- Keeps your global system clean — no need to constantly upgrade/downgrade your system-wide Flutter installation.

Do I need it?
- No, but we strongly recommend using it, to reduce problems with package compatibility and other bugs.

To get started:
For different IDEs and Systems if you have a problem look here: (Official Medium Blog article)[https://medium.com/@ahmedawwan/flutter-version-management-a-guide-to-using-fvm-dbe1d269f565]

```sh
# Install FVM (if not yet installed)
dart pub global activate fvm

# Install the Flutter version defined in this project
fvm install

# Use the Flutter SDK for this project
fvm flutter pub get

# EXAMPLE: So everytime you want to execute anything regarding Flutter/ Dart add fvm in fron of the command like this 
fvm flutter run 
fvm dart pub get 

```

To make it default, you can alias `fvm flutter` as `flutter` in your shell (globaly), so you don’t have to type `fvm` every time. Another option - recommended only for unix based systems - would be [direnv](https://direnv.net/).


### Running the App

To run the app on an emulator or physical device:

1. **Start an Emulator** (if you don't have a physical device connected):
    - **Android**: Start the Android emulator from Android Studio or use a command line tool.
    - **iOS**: Start the iOS simulator from Xcode (macOS only).

2. **Check Build Flavors** (we use separate environments for development and production):
    - **Visual Studio Code**: Build Flavors are already set in `.vsocde/launch.json`.
    - **Android Studio**: Add two new configurations with `--flavor dev -t lib/main.dart` and `--flavor prod -t lib/main.dart` as additional run arguments.

4. **Run the App**:
    ```sh
    flutter run
    ```

</br>

## Project Structure

Here's a brief overview of the main directories in the project, using the Mensa module as an example. We develop the app using multiple independent modules to ensure better scalability, separation of concerns, and easier maintainability as the project grows.

```
.
├── android/                       # Configurations for the Android platform
├── core/                          # App-wide assets like colors, fonts, and shared components
│
├── lib/
│   ├── assets/                    # Pictures and files accessible in components
│   └── src/
│       ├── api/                   # Basic API operations with the backend
│       ├── components/            # Common reusable widgets
│       ├── constants/             # Sizing constants and dev strings
│       ├── core_services/         # Permission handling and core platform services
│       ├── extensions/            # Extensions for common high-level widgets
│       ├── localizations/         # Generated translations
│       ├── logs/                  # In-app message logging
│       ├── pages/                 # High-level pages like app update screens
│       ├── themes/                # Color themes and design tokens
│       └── utils/                 # Utility methods and helper classes
│
├── feature_modules/               # Folder of modules (e.g., mensa, cinema, sport, ...)
│   └── mensa/
│       └── src/
│           ├── bloc/              # State management (e.g., BLoC/Cubit)
│           ├── extensions/        # Feature-specific extensions
│           ├── pages/             # Pages visible to the user
│           ├── repository/        # API operations and model classes
│           ├── routes/            # Routing definitions for this module
│           ├── services/          # User interactions, search, and shared files
│           └── widgets/           # UI components for this module
│
├── ios/                           # Configurations for the iOS platform
├── l10n/                          # Localizations for supported languages
├── shared-api/                    # Shared files, widgets, and logic across modules
├── Makefile                       # Pre-built shell commands for automation
├── pubspec.yaml                   # Project dependencies and package config
└── test/                          # Test files
```

</br>

## License

This project is licensed under the GPLv3 License. See the [LICENSE](LICENSE) file for more information.

</br>

