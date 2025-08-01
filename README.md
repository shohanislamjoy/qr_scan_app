# QR Scan App

A Flutter application for scanning QR codes and retrieving information via API calls.

## Features

- **QR Code Scanning**: Uses device camera to scan QR codes
- **Smart Detection**: Automatically identifies different types of QR content (URLs, emails, numbers, text)
- **API Integration**: Sends scanned data to API for processing (configurable)
- **Cross-platform**: Supports Android and iOS

## Getting Started

### Prerequisites

- Flutter SDK (>=2.17.0)
- Android Studio or VS Code with Flutter extensions
- Physical device or emulator with camera support

### Installation

1. Clone the repository:
```bash
git clone https://github.com/shohanislamjoy/qr_scan_app.git
cd qr_scan_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Permissions

### Android
Camera permission is automatically requested when the app starts. The app includes the following permissions in `android/app/src/main/AndroidManifest.xml`:
- `CAMERA` - Required for QR code scanning
- `INTERNET` - Required for API calls

### iOS
Camera permission is handled automatically. The usage description is included in `ios/Runner/Info.plist`:
- `NSCameraUsageDescription` - "This app needs camera access to scan QR codes."

## Project Structure

```
lib/
├── main.dart           # App entry point
├── scan_qr_page.dart   # QR scanning UI and logic
└── api_service.dart    # API service for processing QR data

android/                # Android platform configuration
ios/                    # iOS platform configuration
test/                   # Unit and widget tests
```

## Configuration

To use with a real API, update the `_baseUrl` in `lib/api_service.dart` and uncomment the HTTP request code.

## Testing

Run tests with:
```bash
flutter test
```

## Build

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

## Dependencies

- `flutter`: Flutter SDK
- `qr_code_scanner`: QR code scanning functionality
- `http`: HTTP requests for API calls
- `flutter_lints`: Dart/Flutter linting rules