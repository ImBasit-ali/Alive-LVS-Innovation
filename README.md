# Alive — Live Streaming Flutter App 🎥

[![Flutter](https://img.shields.io/badge/Flutter-Latest%20Stable-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-brightgreen?style=for-the-badge)](#)
[![Download APK](https://img.shields.io/badge/Download-APK-00A651?style=for-the-badge&logo=android&logoColor=white)](build/app/outputs/flutter-apk/app-release.apk)

**Alive** is a professional, high-fidelity live streaming mobile application built with Flutter. It utilizes a clean **MVVM architecture** with Firebase Authentication (Email/Password & Google Sign-In) and features a modern, premium light theme UI with lime-green gradient styling, custom Bezier wave clipping, and a custom curved bottom navigation bar.

---

## 🚀 Download & Run APK

You can download the compiled production-ready Android APK directly by clicking the button below:

<p align="center">
  <a href="build/app/outputs/Alive.apk" target="_blank">
    <img src="https://img.shields.io/badge/DOWNLOAD%20RELEASE%20APK-00A651?style=for-the-badge&logo=android&logoColor=white&labelColor=28B446" alt="Download APK Button" height="60">
  </a>
</p>

*Note: If downloading directly from GitHub, you can find the release APK file inside the `build/app/outputs/flutter-apk/` directory or download it from the Repository Releases section.*

---

## ✨ Features

1. **Splash Screen**
   * Smooth elastic scale-in and fade animations displaying the custom Alive logo.
   * Auto-navigates based on user authentication session state.

2. **Authentication (MVVM & Firebase)**
   * **Firebase Authentication**: Full email and password sign-in and sign-up with real-time field validation.
   * **Google Sign-In**: Interactive Google Sign-In flow with a custom-painted brand button.
   * **Facebook Sign-In**: Fully designed Facebook brand button ready for integration.
   * **Layered Wave Background**: Bottom sheet area styled with a double-layered cubic Bezier wave (dark green background overlay + lime-green gradient foreground).
   * **Adaptive Layout**: Responsive scrolling setup that naturally resizes and scrolls when input fields are active or when the virtual keyboard is open, preventing pixel overflows.

3. **Home Stream Grid**
   * **Header**: Pinned top bar with Alive logo, notification button with a red badge counter (`3`), and a green Wallet action button that triggers the profile settings & Sign-Out menu.
   * **TabBar View Selector**: Tab selector with "Stream", "Hot", and "Follow" screens.
   * **Country selectors**: Horizontal scrolling category tags (Global, India, Philippines, Brazil, Vietnam) with flags.
   * **2-Column Livestream Feed**: High-fidelity cards showing live viewer counts, streamer names, flag indicators, and custom follow states.
   * **Curved Navigation Bar**: Curved bottom bar matching the screenshots.
   * **Active "Go Live" Trigger**: Circular floating action button that transforms to the active gradient state with a white transmission wave icon when selected.

---

## 🛠️ Tech Stack & Libraries

* **Framework**: Flutter (Latest Stable Version)
* **Language**: Dart
* **State Management**: Provider (ChangeNotifier-based MVVM)
* **Authentication**: Firebase Auth & Google Sign-In
* **Typography**: Google Fonts (Poppins)

---

## 📂 Codebase Architecture (MVVM)

The project follows a modular and readable structure separating UI logic from the data/business rules:

```
lib/
├── constants/
│   └── app_constants.dart    # App hex colors, string assets, sizes, and routes
├── theme/
│   └── app_theme.dart        # Global light ThemeData styling (text, buttons, inputs)
├── services/
│   └── auth_service.dart     # Service layer wrapper for Firebase Auth & Google Sign-in
├── providers/
│   └── auth_provider.dart    # ViewModel provider state machine (ChangeNotifier)
├── screens/
│   ├── splash_screen.dart    # Animated splash view
│   ├── login_screen.dart     # Form login and double-wave layout
│   ├── signup_screen.dart    # Signup view with validation
│   └── home_screen.dart      # Grid view, curved navigation, and floating center tab
├── widgets/
│   └── google_sign_in_button.dart # Custom-painted Google auth button widget
└── main.dart                 # App initialization, routing setup, and entry point
```

---

## ⚙️ Local Development Setup

### Prerequisites
1. Install [Flutter SDK](https://flutter.dev/docs/get-started/install).
2. Configure a mobile emulator or connect a physical developer device.

### Getting Started
1. Clone this repository:
   ```bash
   git clone <your-repository-url>
   cd developer
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run code analysis:
   ```bash
   flutter analyze
   ```
4. Build and run the app:
   ```bash
   flutter run
   ```

### Building the Release APK
To build a release version of the APK for installation:
```bash
flutter build apk --release
```
The output file will be generated at:
`build/app/outputs/flutter-apk/app-release.apk`
