# LMU Students App

[![Download App](https://img.shields.io/badge/Download-App-287FF4?style=flat)](https://lmu-app.lmu-dev.org/)
[![Website](https://img.shields.io/badge/Visit-Website-0B7E32?style=flat)](https://www.lmu-dev.org/)
[![Instagram](https://img.shields.io/badge/Follow-Instagram-FF1B64?style=flat)](https://www.instagram.com/lmu.developers/)
[![LinkedIn](https://img.shields.io/badge/Follow-LinkedIn-0077B5?style=flat)](https://www.linkedin.com/company/105490877/)
![GitHub License](https://img.shields.io/github/license/lmu-devs/lmu_app_client?color=F1F1F1&style=flat&label=License)

Your Companion for Study and Campus Life at LMU Munich.

Developed by students for students, the LMU Students app provides a platform for the LMU community to easily access information about their study as well as LMU services, making university life more convenient and enjoyable.

Supported Platforms: Android, iOS

</br>

## Table of Contents

- [About](#about)
- [Features](#features)
- [Development](#development)
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

1. **Flutter SDK 3.22.3**: Download and install Flutter from the official [Flutter website](https://flutter.dev/docs/get-started/install).
[Download MacOS ARM](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.22.3-stable.zip), [Download Windows x64](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.22.3-stable.zip)
2. **Dart SDK**: This comes bundled with the Flutter SDK.
3. **Android Studio** or **Visual Studio Code**: These are the recommended IDEs for Flutter development.
4. **Android SDK**: Necessary for building and running Android apps.
5. **Xcode**: Required for building and running iOS apps (macOS only).

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

Here's a brief overview of the main directories in the project with the mensa module as an example:

- `android`: Configurations for the Android platform.
- `core/`: Contains app wide assets like colors, font styles and fundamental interface components.
  - `lib/` 
    - `assets`: Pictures and files that can be accessed in components. 
    - `src/`:
      - `api/`: Basic api operations with backend.
      - `components/`: Directory for common widgets.
      - `constants/`: Sizing constants and dev strings.
      - `core_services`: Permission handling.
      - `extensions`: Extensions for common, high-level widgets.
      - `localizations`: Generated translations.
      - `logs`: Logging of in-app messages.
      - `pages`: High-level pages, e.g. app update screen for deprecated versions.
      - `themes/`: Color themes, design tokens.
      - `utils/`: High-level utility methods and classes.
- `feature_modules/`: List of all features (like Mensa, Noten)
  - `mensa/`:
    - `src`:
      - `bloc`: State management.
      - `extensions`: Extensions on classes and objects.
      - `pages`: Pages of the module which are showed to the user.
      - `repository`: Api operations and model classes.
      - `routes`: Routing for the module pages.
      - `services`: Services for user interactions, search and shared files accross modules.
      - `widgets`: Components of the module.
- `ios`: Configurations for the iOS platform. 
- `l10n`: Localizations for the supported languages.
- `shared-api`: Shared files accross modules. 
- `Makefile`: Pre-built shell commands for quick operations.
- `pubspec.yaml`: Dependencies and packages of the project.
- `test/`: Contains the unit and widget test files.

</br>

## License

This project is licensed under the GPLv3 License. See the [LICENSE](LICENSE) file for more information.

</br>

