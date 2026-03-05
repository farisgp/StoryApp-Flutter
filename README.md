# StoryApp Flutter

StoryApp is a mobile application built using **Flutter** that allows users to share stories with images and text. The application integrates with a REST API for user authentication and story management.

This project was developed as part of a learning exercise to implement **Flutter mobile development with API integration**, including authentication, image upload, and displaying dynamic data.

---

## Features

- User Registration
- User Login Authentication
- Display list of stories from API
- View story details
- Add new story with image upload and location
- Logout functionality
- Loading and error handling

---

## Tech Stack

The application is built using the following technologies:

- **Flutter**
- **Dart**
- **REST API**
- **HTTP Package**
- **Material Design**

---

## Installation

### 1. Clone the repository
```bash
git clone https://github.com/farisgp/StoryApp-Flutter.git
```

### 2. Navigate to the project directory
```bash
cd StoryApp-Flutter
```

### 3. Install dependencies
```bash
flutter pub get
```

### 4. Run the application
```bash
flutter run
```

## Requirements

Make sure you have the following installed:
- Flutter SDK
- Dart
- Android Studio or Visual Studio Code
- Android Emulator or Physical Device

Check your Flutter installation:
```bash
flutter doctor
```

## Google Maps API Setup

This project uses **Google Maps API** to display story locations on a map.

For security reasons, the **Google Maps API key is not included in this repository**.  
You must provide your own API key to run the map features.

### Steps to Add Your API Key

1. Create a Google Maps API key from the Google Cloud Console  
   https://console.cloud.google.com/

2. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS

3. Add your API key to the Android configuration file:

`android/app/src/main/AndroidManifest.xml`

Replace the placeholder with your API key:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY"/>
```

4. Rebuild the application
```bash
flutter clean
flutter pub get
flutter run
```
