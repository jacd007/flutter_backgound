import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class CheckPlatform {
  CheckPlatform._();

  /// is Platform Web
  static bool get isModeWeb => kIsWeb;

  /// is Platform Mobile (IOS or Android) && web
  static bool get isModeCropper {
    if (kIsWeb) return true;
    return Platform.isAndroid || Platform.isIOS;
  }

  /// is Platform Mobile (IOS or Android)
  static bool get isModeMobile {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }

  /// is Platform Desktop (Windows or Linux or MacOS)
  static bool get isModeDesktop {
    if (kIsWeb) return false;
    return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }

  /// is Platform is Android
  static bool get isAndroid {
    if (kIsWeb) return false;
    return Platform.isAndroid;
  }

  /// is Platform is IOS
  static bool get isIOS {
    if (kIsWeb) return false;
    return Platform.isIOS;
  }

  /// is Platform is Windows
  static bool get isWindows {
    if (kIsWeb) return false;
    return Platform.isWindows;
  }

  /// is Platform isLinux
  static bool get isLinux {
    if (kIsWeb) return false;
    return Platform.isLinux;
  }

  /// is Platform is MacOS
  static bool get isMacOS {
    if (kIsWeb) return false;
    return Platform.isMacOS;
  }

  /// is Platform is Fuchsia
  static bool get isFuchsia {
    if (kIsWeb) return false;
    return Platform.isFuchsia;
  }
}
