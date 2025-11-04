import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  //
  late SharedPreferences _preferences;

  /// From:
  /// ```
  /// String _sharedTheme = StorageKeys.theme;
  /// ```
  final String _sharedTheme = 'sharedTheme';

  /// index current position Theme mode
  int index = ThemeMode.system.index;

  ///! Getting Theme Stage From Shared and Set it to the ThemeMode this will be
  /// used in main.dart file
  ThemeMode get themeStateSettings => ThemeMode.values[index];

  @override
  void onInit() {
    _getThemeFromShared();
    super.onInit();
  }

  /// private Method to Get Shared Storage theme Setting value adn Return it
  Future<int> _getThemeFromShared() async {
    _preferences = await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance());

    final pref = _preferences.getInt(_sharedTheme) ?? index;
    index = pref;
    final themeStateSettings = ThemeMode.values[pref];
    update();

    // await _preferences.clear();
    Get.changeThemeMode(themeStateSettings);
    debugPrint('Theme Mode: ${themeStateSettings.name}');

    return pref;
  }

  /// Method to change the Theme State when the user call it via Theme Change
  /// Button
  Future<void> changeTheme(ThemeMode mode) async {
    index = mode.index;
    debugPrint('Change theme mode: ${themeStateSettings.name}');
    update();

    await _preferences.setInt(_sharedTheme, index);
    Get.changeThemeMode(ThemeMode.values[index]);
  }

  /// Method for the theme when the user calls it using the cleanup function
  Future<void> cleanup() async {
    index = ThemeMode.system.index;
    debugPrint('Clean Theme...');
    update();

    await _preferences.setInt(_sharedTheme, index);
    Get.changeThemeMode(ThemeMode.values[index]);
  }
}
