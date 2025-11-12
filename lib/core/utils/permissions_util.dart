// permissions_util.dart

// ignore_for_file: use_build_context_synchronously

import 'dart:io' show Platform;
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionUtil {
  /// 1. Verifica los permisos de GPS (Always/Permanente).
  /// 2. Si no están en "Always", solicita los permisos.
  /// 3. Si el usuario no los otorga, abre la configuración de la aplicación.
  /// @returns true si el permiso es LocationPermission.always
  static Future<bool> _checkLocationPermissions(BuildContext context) async {
    // Verificar si el servicio de ubicación del dispositivo está activo.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'El servicio de ubicación está desactivado. Por favor, actívalo.',
          ),
        ),
      );
      await Geolocator.openLocationSettings();
      return false;
    }

    // Paso 1: Obtener el permiso actual
    LocationPermission permission = await Geolocator.checkPermission();

    // Paso 2: Si está denegado, solicitarlo (WhileInUse)
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Paso 3: Si se otorgó WhileInUse (o ya estaba), solicitar LocationAlways/Permanente
    if (permission == LocationPermission.whileInUse) {
      await Permission.locationAlways.request();
      // Volver a chequear el estado después de la solicitud
      permission = await Geolocator.checkPermission();
    }

    // Paso 4: Si se denegó Permanentemente (o After request) abrir la configuración de la app.
    if (permission == LocationPermission.deniedForever ||
        permission != LocationPermission.always) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Necesitamos el permiso de Ubicación "Permitir siempre" para el seguimiento en segundo plano. Por favor, actívalo en la configuración.',
          ),
          duration: Duration(seconds: 5),
        ),
      );
      await Geolocator.openAppSettings();
      return false;
    }

    // El permiso es LocationPermission.always
    return true;
  }

  /// Verifica si la Optimización de Batería está deshabilitada (ignoring battery optimizations)
  /// Si no lo está, lleva al usuario a la configuración para desactivarla.
  /// @returns true si la optimización de batería está deshabilitada (es decir, la app es ignorada).
  static Future<bool> _checkBatteryOptimization(BuildContext context) async {
    if (!Platform.isAndroid) {
      return true;
    }
    final bool allDisabled =
        (await DisableBatteryOptimization.isAllBatteryOptimizationDisabled) ??
        false;

    if (!allDisabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'La Optimización de Batería debe estar desactivada para el seguimiento continuo. Por favor, desactívala para esta aplicación.',
          ),
          duration: Duration(seconds: 5),
        ),
      );
      // Abre la pantalla (nativa y del fabricante) para desactivar todas las optimizaciones.
      await DisableBatteryOptimization.showDisableAllOptimizationsSettings(
        'Habilitar auto-inicio',
        'Sigue los pasos y habilita el auto-inicio para esta app.',
        'Desactivar optimizaciones del fabricante',
        'Sigue los pasos y desactiva las optimizaciones adicionales para esta app.',
      );
      return false;
    }

    return true;
  }

  /// 🚀 Función principal para verificar todos los permisos requeridos antes de iniciar el seguimiento.
  /// Verifica GPS Permanente y Optimización de Batería.
  /// @returns true si ambos chequeos pasan.
  static Future<bool> checkAllBackgroundPermissions(
    BuildContext context,
  ) async {
    // 1. Verificar y solicitar permisos de Ubicación Permanente
    bool locationOk = await _checkLocationPermissions(context);
    if (!locationOk) {
      return false;
    }

    // 2. Verificar y solicitar desactivación de Optimización de Batería (solo Android)
    bool batteryOk = await _checkBatteryOptimization(context);
    if (!batteryOk) {
      return false;
    }

    // Ambos permisos requeridos están activos.
    return true;
  }
}
