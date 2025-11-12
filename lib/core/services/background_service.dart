import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../constants/storage_keys.dart';
import '../utils/shared_prefs.dart';

class BackgroundServiceManager {
  static const _notificationChannelId = 'bg_location';
  static const _notificationId = 981;

  static Future<void> initialize() async {
    final service = FlutterBackgroundService();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _notificationChannelId,
      'Background Location',
      description: 'Location updates in foreground service',
      importance: Importance.low,
    );
    final FlutterLocalNotificationsPlugin flnp =
        FlutterLocalNotificationsPlugin();
    await flnp
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: onStart,
        isForegroundMode: true,
        autoStartOnBoot: false,
        notificationChannelId: _notificationChannelId,
        initialNotificationTitle: 'Servicio de ubicación',
        initialNotificationContent: 'Enviando cada 5 segundos',
        foregroundServiceNotificationId: _notificationId,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );

    final enabled = await SharedPrefs.getBool(
      StorageKeys.bgServiceEnabled,
      false,
    );
    if (enabled) {
      await start();
    }
  }

  static Future<bool> isRunning() async {
    return await FlutterBackgroundService().isRunning();
  }

  static Future<bool> start() async {
    final ok = await _ensurePermissions();
    if (!ok) return false;
    final running = await isRunning();
    if (!running) {
      await FlutterBackgroundService().startService();
    }
    await SharedPrefs.setBool(StorageKeys.bgServiceEnabled, true);
    return true;
  }

  static Future<void> stop() async {
    FlutterBackgroundService().invoke('stop');
    await SharedPrefs.setBool(StorageKeys.bgServiceEnabled, false);
  }

  static Future<bool> _ensurePermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse) {
      await Permission.locationAlways.request();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}

const _defaultServerUrl = 'https://xxxxxxxxx/xxxxx';

Future<String> _resolveServerUrl() async {
  final saved = await SharedPrefs.getString(
    StorageKeys.bgServiceUrl,
    _defaultServerUrl,
  );
  return saved.isNotEmpty ? saved : _defaultServerUrl;
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  service.on('stop').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (!await service.isForegroundService()) {
        debugPrint('[BG] not foreground, skip');
        return;
      }
    }

    try {
      debugPrint('[BG] tick ${DateTime.now().toIso8601String()}');
      Position? pos;
      try {
        pos = await Geolocator.getCurrentPosition();
      } catch (e) {
        debugPrint('[BG] getCurrentPosition error: $e');
      }
      pos ??= await Geolocator.getLastKnownPosition();
      if (pos == null) {
        debugPrint('[BG] no position available');
        return;
      }
      debugPrint(
        '[BG] position lat=${pos.latitude}, lon=${pos.longitude}, acc=${pos.accuracy}',
      );
      final url = await _resolveServerUrl();
      final body = jsonEncode({
        'timestamp': DateTime.now().toIso8601String(),
        'latitude': pos.latitude,
        'longitude': pos.longitude,
        'accuracy': pos.accuracy,
        'altitude': pos.altitude,
        'speed': pos.speed,
        'speedAccuracy': pos.speedAccuracy,
        'heading': pos.heading,
      });
      final resp = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      final code = resp.statusCode;
      debugPrint('[BG] posted -> $code');
      if (code < 200 || code >= 300) {
        debugPrint('[BG] response body: ${resp.body}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  });
}
