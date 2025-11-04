// lib/core/constants/assets.dart
// ignore_for_file: constant_identifier_names

class Assets {
  Assets._();

// ==================================================================
  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons';
// ==================================================================
  static List<String> get icons => [
        menu1,
        menu2,
        menu3,
        menu4,
        menu5,
      ];

// ====================== IMAGES ======================

  /// Logo and Icons APP
  static const String logoBG = '$_images/bg.png';
  static const String logo = '$_images/icon.png';
  static const String logoIcon2 = '$_images/icon2.png';

  /// icon page not found
  static const String imgPageNotFound = '$_images/not_found.png';

  /// Logo Splash
  static const String logoSplash = '$_images/splash.png';

  /// avatar
  static const String logoAvatar = '$_images/ic_avatar.png';

  /// avatar trans
  static const String logoAvatar2 = '$_images/ic_avatar2.png';

  /// icon banner def
  static const String iconBanner = '$_images/banner.png';

  /// icon HV
  static const String icHV = '$_images/ic_company_1.png';

  /// icon HV 2
  static const String icHV2 = '$_images/ic_company_2.png';

  /// icon logo HV horizontal
  static const String imgHVHorizontal = '$_images/ic_logo_company.png';

  /// image Background Error not found
  static const String imgBgError = '$_images/bg_error.png';

  /// image icon Color
  static const String icColors = '$_images/ic_colors.png';

  /// image icon logo template from company
  static const String icLogoTemplate = '$_images/ic_logo.png';

// ====================== ICONS ======================

  // icons menu
  static const String menu1 = '$_icons/menu1.png';
  static const String menu2 = '$_icons/menu2.png';
  static const String menu3 = '$_icons/menu3.png';
  static const String menu4 = '$_icons/menu4.png';
  static const String menu5 = '$_icons/menu5.png';

  /// icon card
  static const String icCard = '$_icons/ic_card.png';

  /// icon default search image
  static const String icDefault = '$_icons/ic_default.png';

  /// icon phone
  static const String icPhone = '$_icons/ic_phone.png';

  /// icon report
  static const String icReport = '$_icons/ic_report.png';

  /// icon settings
  static const String icSettings = '$_icons/ic_settings.png';

  /// icon whatApp
  static const String icWhatApp = '$_icons/ic_whatApp.png';

  /// icon world
  static const String icWorld = '$_icons/ic_world.png';

  // ==========================================================================
  // ================================= CUSTOM =================================
  // ==========================================================================

  /// icon show text 1
  static const String icShowText = '$_icons/ic_show_text.png';

  /// icon show text 2
  static const String icShowText2 = '$_icons/ic_show_text2.png';

  /// icon show qr
  static const String icShowQr = '$_icons/ic_show_qr.png';

  /// icon show barcode
  static const String icShowBarCode = '$_icons/ic_show_barcode.png';

  /// icon show image
  static const String icShowImage = '$_icons/ic_show_image.png';

//  /// icon xxx
//  static const String icXxx = '$_icons/ic_xxx.png';
}
