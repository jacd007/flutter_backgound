import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

class AppColors {
  AppColors._();

  /// Returns true if the current brightness is dark mode
  ///
  /// [ctx] The build context to get the current brightness from.
  /// If null, [Get.context] is used instead.
  static bool isMode([BuildContext? ctx]) {
    bool isDark = false;
    Brightness currentBrightness = Brightness.light;

    try {
      final c = ctx ?? Get.context;

      if (c != null) currentBrightness = Theme.of(c).brightness;
      isDark = currentBrightness == Brightness.dark;
      return isDark;
    } on Exception catch (_) {
      return false;
    }
  }

  static bool get isDark => isMode();

  // ** Brand colors

  /// Custom Color App
  static Color get primary => isDark
      ? MaterialTheme.darkScheme().primary
      : MaterialTheme.lightScheme().primary;

  /// Custom Color App
  static Color get secondary => isDark
      ? MaterialTheme.darkScheme().secondary
      : MaterialTheme.lightScheme().secondary;

  /// Custom Color App
  static Color get tertiary => isDark
      ? MaterialTheme.darkScheme().tertiary
      : MaterialTheme.lightScheme().tertiary;

  /// Custom Color App
  static Color get alternate => isDark
      ? MaterialTheme.darkScheme().onTertiaryFixedVariant
      : MaterialTheme.lightScheme().onTertiaryFixedVariant;

  // ** Utility colors

  /// Custom Color App
  static Color get primaryText =>
      isDark ? Color(0xDD000000) : Color(0xFFFFFFFF);

  /// Custom Color App
  static Color get secondaryText =>
      isDark ? Color(0xFF757575) : Color(0xFFBDBDBD);

  /// Custom Color App
  static Color get primaryBackground =>
      isDark ? Color(0xFFFAFAFA) : Color(0xFF212121);

  /// Custom Color App
  static Color get secondaryBackground =>
      isDark ? Color(0xFFFFFFFF) : Color(0xFF303030);

  // ** Accent colors

  /// Custom Color App
  static Color get accent1 => isDark
      ? MaterialTheme.darkScheme().primary.withValues(alpha: .3)
      : MaterialTheme.lightScheme().primary.withValues(alpha: .3);

  /// Custom Color App
  static Color get accent2 => isDark
      ? MaterialTheme.darkScheme().secondary.withValues(alpha: .3)
      : MaterialTheme.lightScheme().secondary.withValues(alpha: .3);

  /// Custom Color App
  static Color get accent3 => isDark
      ? MaterialTheme.darkScheme().tertiary.withValues(alpha: .3)
      : MaterialTheme.lightScheme().tertiary.withValues(alpha: .3);

  /// Custom Color App
  static Color get accent4 => isDark
      ? MaterialTheme.darkScheme().onTertiaryFixedVariant.withValues(alpha: .3)
      : MaterialTheme.lightScheme().onTertiaryFixedVariant.withValues(
          alpha: .3,
        );

  // ** Semantic colors

  /// Custom Color App
  static Color get success => Color(0xFF4CAF50);

  /// Custom Color App
  static Color get error => Color(0xFFF44336);

  /// Custom Color App
  static Color get warning => Color(0xFFFFC107);

  /// Custom Color App
  static Color get info => Color(0xFFFFFFFF);

  // ** Custom colors

  /// Custom Color App
  static Color get overlay => isDark ? Color(0x99FAFAFA) : Color(0x99212121);

  /// Custom Color App
  static Color get background => isDark ? Colors.black : Colors.white;

  /// Custom Color App
  static Color get foreground => isDark ? Colors.white : Colors.black;

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color black54 = Colors.black54;
  static const Color transparent = Colors.transparent;
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color brown = Colors.brown;
  static const Color pink = Colors.pink;
  static const Color purple = Colors.purple;
  static const Color amber = Colors.amber;
  static const Color orange = Colors.orange;
  static const Color indigo = Colors.indigo;
  static const Color lime = Colors.lime;
  static const Color teal = Colors.teal;
  static const Color cyan = Colors.cyan;
  static const Color yellow = Colors.yellow;
  static const Color yellowAccent = Color(0xFFf9e958);
  static const Color blue = Colors.blue;
  static const Color blueGrey = Colors.blueGrey;
  static const Color blueAccent = Colors.blueAccent;
  static const Color grey = Colors.grey;
  static final Color grey100 = Colors.grey.shade100;
  static final Color grey600 = Colors.grey.shade600;
  static final Color grey700 = Colors.grey.shade700;
  static final Color grey800 = Colors.grey.shade800;
  static final Color grey900 = Colors.grey.shade900;

  // const Color scaffoldBackgroundColorLight = Color.fromARGB(255, 247, 247, 247);
  // const Color scaffoldBackgroundColor = Color.fromARGB(255, 24, 24, 24);
  // const Color appBarColor = Color.fromARGB(255, 245, 245, 245);
  // const Color appBarColorDark = Color(0xFF3B2E33);
  // const Color cardColorDark = Color(0xFF343434);
  // const Color cardColorDark2 = Color(0xFF31313A);

  // const Color buttonColor = Color(0xFF8b21b8);
  // const defaultColor = Colors.white;

  // *******************************************************************************

  static TextTheme createTextTheme(
    BuildContext context,
    String bodyFontString,
    String displayFontString,
  ) {
    TextTheme baseTextTheme = Theme.of(context).textTheme;
    TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
      bodyFontString,
      baseTextTheme,
    );
    TextTheme displayTextTheme = GoogleFonts.getTextTheme(
      displayFontString,
      baseTextTheme,
    );
    TextTheme textTheme = displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
    return textTheme;
  }
}

// ******************************************************

extension AppThemeTextOption on TextStyle {
  ///
  TextStyle get primaryColor => copyWith(color: AppColors.primary);

  ///
  TextStyle get primaryBackgroundColor =>
      copyWith(color: AppColors.primaryBackground);

  ///
  TextStyle get primaryTextColor => copyWith(color: AppColors.primaryText);

  ///
  TextStyle get secondaryTextColor => copyWith(color: AppColors.secondaryText);

  ///
  TextStyle get errorColor => copyWith(color: AppColors.error);

  ///
  TextStyle get successColor => copyWith(color: AppColors.success);

  ///
  TextStyle get foregroundColor => copyWith(color: AppColors.foreground);

  ///
  TextStyle get backgroundColor => copyWith(color: AppColors.background);
}

// *******************************************************************************

extension ThemeOptions on ThemeData {
  ThemeData notMaterial() {
    // ignore: deprecated_member_use
    return copyWith(useMaterial3: false);
  }
}

extension ButtonStyleCustom on ButtonStyle {
  ///
  ButtonStyle styleFrom({
    WidgetStateProperty<TextStyle?>? textStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? overlayColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    Color? iconColor,
    double? iconSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? mouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    //
    WidgetStateProperty<T>? materialStateProperty<T>(T? color) {
      return color == null ? null : WidgetStateProperty.all<T>(color);
    }

    return ButtonStyle(
      backgroundColor: materialStateProperty(backgroundColor),
      foregroundColor: materialStateProperty(foregroundColor),
      shadowColor: materialStateProperty(shadowColor),
      surfaceTintColor: materialStateProperty(surfaceTintColor),
      elevation: materialStateProperty(elevation),
      padding: materialStateProperty(padding),
      minimumSize: materialStateProperty(minimumSize),
      maximumSize: materialStateProperty(maximumSize),
      iconColor: materialStateProperty(iconColor),
      iconSize: materialStateProperty(iconSize),
      side: materialStateProperty(side),
      shape: materialStateProperty(shape),
      mouseCursor: materialStateProperty(mouseCursor),
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }
}

extension HexColor on Color {
  /// Converts a [Color] to a hex string.
  ///
  /// The returned string will be in the format `#AARRGGBB`, where `AA` is the
  /// alpha channel, `RR` is the red component, `GG` is the green component,
  /// and `BB` is the blue component.
  ///
  /// If the color is invalid, the `defaultColor` parameter is returned.
  ///
  /// If `removeHash` is `true`, the `#` character will be removed from the
  /// returned string.
  ///
  /// Example:
  ///
  ///
  String fromColor({
    String defaultColor = '#FF000000',
    bool removeHash = false,
  }) {
    try {
      // ignore: deprecated_member_use
      final color = '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
      return removeHash ? color.replaceAll("#FF", "#") : color;
    } catch (_) {
      return removeHash ? defaultColor.replaceAll("#FF", "#") : defaultColor;
    }
  }

  //
  Color setAlpha(double percent) {
    return withAlpha((256 * percent.clamp(0, 1)).toInt());
  }
}

extension HexColorX on String {
  /// Converts a hexadecimal color string to a [Color] object.
  ///
  /// This function assumes the string is in the format `#RRGGBB` or `#AARRGGBB`.
  /// If the string is invalid, it returns the primary color from [AppColors].
  ///
  /// Returns:
  /// - A [Color] object corresponding to the given hexadecimal string.
  ///
  /// Throws:
  /// - Returns [AppColors.primary] if the string cannot be parsed.
  Color toColor() {
    try {
      return Color(int.parse(substring(1), radix: 16) + 0xFF000000);
    } catch (_) {
      return AppColors.primary;
    }
  }
}
