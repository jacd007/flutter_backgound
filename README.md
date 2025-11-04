# flutter_background_2

Servicio de ubicación en segundo plano (Foreground Service) que envía la posición por HTTP cada 5 segundos. Incluye pantalla de prueba para iniciar/detener el servicio y configurar la URL de envío.

## Resumen
- **Objetivo**: Ejecutar código en background de forma continua (incluso con la app cerrada) y enviar GPS por POST cada 5s.
- **Plataforma principal**: Android (Foreground Service con notificación persistente).
- **Control**: UI con botones de Iniciar/Detener y campo para URL.

## Paquetes utilizados
- `flutter_background_service`: motor del servicio en background.
- `flutter_local_notifications`: creación del canal/notification requerida por Android 8+.
- `geolocator`: obtención de ubicación (foreground/background) y utilidades.
- `permission_handler`: solicitud de permisos (notificaciones y ubicación Always/WhileInUse).
- `http`: envío HTTP POST de la posición.

> Importante: NO agregues manualmente `flutter_background_service_android` en tu pubspec; es el paquete federado interno. Usar directamente puede causar errores en el isolate de background. Solo usa `flutter_background_service`.

### pubspec.yaml (ejemplo)
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

## Configuración de Android

### 1) Permisos y service (AndroidManifest.xml)
Ubicación: `android/app/src/main/AndroidManifest.xml`
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

### 2) Icono pequeño para la notificación
Archivo vectorial en: `android/app/src/main/res/drawable/ic_bg_service_small.xml`
```xml
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M12,2A10,10 0,1,0 22,12A10,10 0,0,0 12,2z"/>
</vector>
```

### 3) Desugaring en Gradle (requerido por notificaciones)
Archivo: `android/app/build.gradle.kts`
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

## Implementación en Dart

### 1) Servicio (`lib/core/services/background_service.dart`)
- Crea un canal de notificación con `flutter_local_notifications` ANTES de configurar el servicio.
- Configura `FlutterBackgroundService` con `AndroidConfiguration`:
  - `isForegroundMode: true`
  - `notificationChannelId: 'bg_location'` (debe coincidir con el canal creado)
  - `initialNotificationTitle/Content`
- En `onStart` (con `@pragma('vm:entry-point')`):
  - Llama `service.setAsForegroundService()` (Android).
  - `Timer.periodic(Duration(seconds: 5))` para obtener GPS y enviar POST.
  - Fallback a `getLastKnownPosition()` si `getCurrentPosition` falla/expira.
  - Logs `print/debugPrint` para trazar ejecución y códigos HTTP.
- `BackgroundServiceManager.start()` valida permisos:
  - Notificaciones (Android 13+).
  - Ubicación (`WhileInUse`/`Always`) y GPS activo.
  - Persiste preferencia del usuario en `SharedPreferences`.

### 2) Inicialización en `main.dart`
Antes de `runApp(...)`:
```dart
WidgetsFlutterBinding.ensureInitialized();
await BackgroundServiceManager.initialize();
```

### 3) UI de prueba (Home)
- Pantalla que muestra estado, permite **Iniciar/Detener** y configurar la **URL**.
- La URL se guarda en `SharedPreferences` para usarla en el servicio.

## Pasos para aplicar en otro proyecto
1. **Agregar dependencias** en `pubspec.yaml` (ver arriba).
2. **Crear** `lib/core/services/background_service.dart` con:
   - Inicialización del canal de notificaciones y `FlutterBackgroundService`.
   - `onStart` con `Timer.periodic` y envío HTTP.
   - Métodos `start/stop/isRunning` y manejo de permisos.
3. **Manifest Android**: permisos + `<service ... foregroundServiceType="location" stopWithTask="false" android:exported="true"/>`.
4. **Icono** `ic_bg_service_small.xml` en `res/drawable`.
5. **Gradle**: habilitar desugaring y agregar `desugar_jdk_libs`.
6. **Inicializar** en `main.dart` llamando `BackgroundServiceManager.initialize()`.
7. **(Opcional)** UI de control para iniciar/detener y cambiar la URL.
8. **Probar en dispositivo real** (no emulador) y conceder permisos.

## Pruebas
- URL de ejemplo: `https://xxxxxxxxx/xxxxx` (cambia por tu endpoint) o prueba con `https://httpbin.org/post`.
- Al iniciar el servicio, verás una notificación persistente.
- En consola deberían aparecer logs `[BG]` con coordenadas y `posted -> <status>`.

## Solución de problemas
- **Bad notification for startForeground**: crea el canal de notificación antes de iniciar el servicio y define `ic_bg_service_small`.
- **Error del plugin en isolate**: no agregues `flutter_background_service_android` al pubspec; usa solo `flutter_background_service`.
- **No llegan posiciones**:
  - Revisa permisos (ubicación “Permitir siempre” si aplica) y que el GPS esté activado.
  - Desactiva optimización de batería/auto-start en OEMs (MIUI/Huawei/etc.).
  - Prueba con `httpbin.org/post` para aislar endpoint/payload/headers.

## Notas
- Mantener intervalos muy cortos afecta la batería. Ajusta según tus necesidades.
- No incluyas llaves o tokens sensibles en el repositorio.
