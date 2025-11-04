# flutter_background_2

Background location foreground service that sends the device position via HTTP every 5 seconds. Includes a test screen to start/stop the service and configure the target URL.

## Overview
- Objective: Run continuous background code (even when the app is closed) and send GPS via POST every 5s.
- Platform: Android (Foreground Service with a persistent notification).
- Control: UI with Start/Stop buttons and a URL input.

## Packages used
- `flutter_background_service`: background execution engine.
- `flutter_local_notifications`: creates the notification channel required on Android 8+.
- `geolocator`: location retrieval (foreground/background) and utilities.
- `permission_handler`: runtime permissions (notifications and location Always/WhileInUse).
- `http`: HTTP POST to send the position.

> Important: DO NOT add `flutter_background_service_android` manually in your pubspec; it is the federated Android package. Adding it directly can cause errors in the background isolate. Only depend on `flutter_background_service`.

### pubspec.yaml (example)
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_background_service: ^5.1.0
  flutter_local_notifications: ^19.5.0
  geolocator: ^14.0.2
  permission_handler: ^12.0.1
  http: ^1.5.0
```

## Android configuration

### 1) Permissions and service (AndroidManifest.xml)
Path: `android/app/src/main/AndroidManifest.xml`
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION" />

    <application ...>
        <service
            android:name="id.flutter.flutter_background_service.BackgroundService"
            android:enabled="true"
            android:exported="true"
            android:foregroundServiceType="location"
            android:stopWithTask="false" />
        ...
    </application>
</manifest>
```

### 2) Small notification icon
Vector asset at: `android/app/src/main/res/drawable/ic_bg_service_small.xml`
```xml
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M12,2A10,10 0,1,0 22,12A10,10 0,0,0 12,2z"/>
</vector>
```

### 3) Gradle desugaring (required by notifications)
Path: `android/app/build.gradle.kts`
```kotlin
android {
  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    isCoreLibraryDesugaringEnabled = true
  }
  kotlinOptions { jvmTarget = JavaVersion.VERSION_11.toString() }
}

dependencies {
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
```

## Dart implementation

### 1) Service (`lib/core/services/background_service.dart`)
- Create a notification channel with `flutter_local_notifications` BEFORE configuring the service.
- Configure `FlutterBackgroundService` with `AndroidConfiguration`:
  - `isForegroundMode: true`
  - `notificationChannelId: 'bg_location'` (must match the created channel)
  - `initialNotificationTitle/Content`
- In `onStart` (with `@pragma('vm:entry-point')`):
  - Call `service.setAsForegroundService()` (Android).
  - Use `Timer.periodic(Duration(seconds: 5))` to get GPS and send POST.
  - Fallback to `getLastKnownPosition()` if `getCurrentPosition` fails/expires.
  - Add `print/debugPrint` logs to trace execution and HTTP codes.
- `BackgroundServiceManager.start()` validates permissions:
  - Notifications (Android 13+).
  - Location (`WhileInUse`/`Always`) and GPS turned on.
  - Persists the user's preference in `SharedPreferences`.

### 2) Initialize in `main.dart`
Before `runApp(...)`:
```dart
WidgetsFlutterBinding.ensureInitialized();
await BackgroundServiceManager.initialize();
```

### 3) Test UI (Home)
- Screen shows status, allows **Start/Stop**, and lets you set the **URL**.
- The URL is saved in `SharedPreferences` and used by the service.

## How to apply this to another project
1. Add dependencies to `pubspec.yaml` (see above).
2. Create `lib/core/services/background_service.dart` with:
   - Notification channel creation and `FlutterBackgroundService` setup.
   - `onStart` with `Timer.periodic` and HTTP sending.
   - `start/stop/isRunning` methods and permission handling.
3. AndroidManifest: permissions + `<service ... foregroundServiceType="location" stopWithTask="false" android:exported="true"/>`.
4. Icon `ic_bg_service_small.xml` in `res/drawable`.
5. Gradle: enable desugaring and add `desugar_jdk_libs`.
6. Initialize in `main.dart` with `BackgroundServiceManager.initialize()`.
7. (Optional) Control UI to start/stop and change the URL.
8. Test on a real device (not emulator) and grant permissions.

## Testing
- Example URL: `https://xxxxxxxxx/xxxxx` (replace with your endpoint) or test with `https://httpbin.org/post`.
- When the service starts, you should see a persistent notification.
- In the console, look for `[BG]` logs with coordinates and `posted -> <status>`.

## Troubleshooting
- Bad notification for startForeground: Create the notification channel before starting the service and set `ic_bg_service_small`.
- Plugin isolate error: Do not add `flutter_background_service_android` to pubspec; only use `flutter_background_service`.
- No positions received:
  - Check permissions (possibly “Allow all the time”) and ensure GPS is on.
  - Disable battery optimization/enable auto-start for OEMs (MIUI/Huawei/etc.).
  - Try with `httpbin.org/post` to isolate endpoint/payload/headers.

## Notes
- Short intervals significantly affect battery usage. Adjust to your needs.
- Do not commit keys or sensitive tokens to the repository.
