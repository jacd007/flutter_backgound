import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static const TextStyle headline1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle headline3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle headline4 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle headline5 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle headline6 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodyText1 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle button = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle overline = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  );
}

// ====================================================================

const fontBold = 'bold';
const fontLight = 'light';
const fontRegular = 'regular';

const TextStyle style = TextStyle(fontSize: 15.0, letterSpacing: 0.0);

extension TextStyleExtension on TextStyle {
  TextStyle styleSelected(bool value, {Color? selected, Color? unselected}) {
    return copyWith(color: value ? selected : unselected);
  }

  /// [Color]
  /// [TextStyle]
  /// Function TextStyle copyWith color primaryColor [0xfff3b404]
  TextStyle get forcePrimaryColor => copyWith(color: Color(0xfff3b404));

  /// [double]
  /// [TextStyle]
  /// Function TextStyle copyWith fontSize
  TextStyle autoSize([double? fontSize]) => copyWith(fontSize: fontSize);

  /// [Color]
  /// [TextStyle]
  /// Function TextStyle copyWith color
  TextStyle autoColor([Color? color]) => copyWith(color: color);

  /// [Color]
  /// [TextStyle]
  /// Function TextStyle copyWith color.
  /// Equal to the [autoColor] function.
  TextStyle forceColor(Color color) => copyWith(color: color);

  /// [Color]
  /// [TextStyle]
  /// Function TextStyle copyWith color white
  TextStyle get forceWhiteColor => copyWith(color: Colors.white);

  /// [Color]
  /// [TextStyle]
  /// Function TextStyle copyWith color black
  TextStyle get forceBlackColor => copyWith(color: Colors.black);

  /// [Color]
  /// [TextStyle]
  /// Function TextStyle copyWith color grey
  TextStyle get forceGreyColor => copyWith(color: Colors.grey);

  // ******************************************

  /// TextStyle fontStyle italic
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// TextStyle fontStyle bold
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// TextStyle underline
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  // ******************************************

  /// TextStyle fontSize 11.0
  TextStyle get fs11 => copyWith(fontSize: 11.0);

  /// TextStyle fontSize 12.0
  TextStyle get fs12 => copyWith(fontSize: 12.0);

  /// TextStyle fontSize 13.0
  TextStyle get fs13 => copyWith(fontSize: 13.0);

  /// TextStyle fontSize 14.0
  TextStyle get fs14 => copyWith(fontSize: 14.0);

  /// TextStyle fontSize 16.0
  TextStyle get fs16 => copyWith(fontSize: 16.0);

  /// TextStyle fontSize 17.0
  TextStyle get fs17 => copyWith(fontSize: 17.0);

  /// TextStyle fontSize 18.0
  TextStyle get fs18 => copyWith(fontSize: 18.0);

  /// TextStyle fontSize 19.0
  TextStyle get fs19 => copyWith(fontSize: 19.0);

  /// TextStyle fontSize 20.0
  TextStyle get fs20 => copyWith(fontSize: 20.0);

  /// TextStyle fontSize 21.0
  TextStyle get fs21 => copyWith(fontSize: 21.0);

  /// TextStyle fontSize 22.0
  TextStyle get fs22 => copyWith(fontSize: 22.0);

  /// TextStyle fontSize 23.0
  TextStyle get fs23 => copyWith(fontSize: 23.0);

  /// TextStyle fontSize 24.0
  TextStyle get fs24 => copyWith(fontSize: 24.0);

  /// TextStyle fontSize 25.0
  TextStyle get fs25 => copyWith(fontSize: 25.0);

  /// TextStyle fontSize 26.0
  TextStyle get fs26 => copyWith(fontSize: 26.0);

  /// TextStyle fontSize 27.0
  TextStyle get fs27 => copyWith(fontSize: 27.0);

  /// TextStyle fontSize 28.0
  TextStyle get fs28 => copyWith(fontSize: 28.0);

  /// TextStyle fontSize 29.0
  TextStyle get fs29 => copyWith(fontSize: 29.0);

  /// TextStyle fontSize 30.0
  TextStyle get fs30 => copyWith(fontSize: 30.0);

  /// TextStyle fontSize 32.0
  TextStyle get fs32 => copyWith(fontSize: 32.0);

  /// TextStyle fontSize 34.0
  TextStyle get fs34 => copyWith(fontSize: 34.0);

  /// TextStyle fontSize 36.0
  TextStyle get fs36 => copyWith(fontSize: 36.0);

  /// TextStyle fontSize 38.0
  TextStyle get fs38 => copyWith(fontSize: 38.0);

  /// TextStyle fontSize 40.0
  TextStyle get fs40 => copyWith(fontSize: 40.0);

  /// TextStyle fontSize 42.0
  TextStyle get fs42 => copyWith(fontSize: 42.0);

  /// TextStyle fontSize 44.0
  TextStyle get fs44 => copyWith(fontSize: 44.0);

  /// TextStyle fontSize 34.0
  TextStyle get fs45 => copyWith(fontSize: 45.0);

  /// TextStyle fontWeight normal
  TextStyle get fw => copyWith(fontWeight: FontWeight.normal);

  /// TextStyle fontWeight w100

  TextStyle get fw100 => copyWith(fontWeight: FontWeight.w100);

  /// TextStyle fontWeight w200

  TextStyle get fw200 => copyWith(fontWeight: FontWeight.w200);

  /// TextStyle fontWeight w300

  TextStyle get fw300 => copyWith(fontWeight: FontWeight.w300);

  /// TextStyle fontWeight w400
  TextStyle get fw400 => copyWith(fontWeight: FontWeight.w400);

  /// TextStyle fontWeight w500
  TextStyle get fw500 => copyWith(fontWeight: FontWeight.w500);

  /// TextStyle fontWeight medium (w500)
  TextStyle get fwMedium => copyWith(fontWeight: FontWeight.w500);

  /// TextStyle fontWeight w600
  TextStyle get fw600 => copyWith(fontWeight: FontWeight.w600);

  /// TextStyle fontWeight w700
  TextStyle get fw700 => copyWith(fontWeight: FontWeight.w700);

  /// TextStyle fontWeight w800
  TextStyle get fw800 => copyWith(fontWeight: FontWeight.w800);

  /// TextStyle fontWeight SemiBold (w800)
  TextStyle get fwSemiBold => copyWith(fontWeight: FontWeight.w800);

  /// TextStyle fontWeight w900
  TextStyle get fw900 => copyWith(fontWeight: FontWeight.w900);

  // *******************************************************************

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Display Large
  TextStyle get displayLarge => copyWith(
    fontFamily: GoogleFonts.outfit().fontFamily,
    fontSize: 48.0,
    fontWeight: FontWeight.normal,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Display Medium
  TextStyle get displayMedium => copyWith(
    fontFamily: GoogleFonts.outfit().fontFamily,
    fontSize: 36.0,
    fontWeight: FontWeight.w800,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Display Small
  TextStyle get displaySmall => copyWith(
    fontFamily: GoogleFonts.outfit().fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w800,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Headline Large
  TextStyle get headlineLarge => copyWith(
    fontFamily: GoogleFonts.outfit().fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.normal,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Headline Medium
  TextStyle get headlineMedium => copyWith(
    fontFamily: GoogleFonts.outfit().fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text headline Small
  TextStyle get headlineSmall => copyWith(
    fontFamily: GoogleFonts.outfit().fontFamily,
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Title Large
  TextStyle get titleLarge => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Title Medium
  TextStyle get titleMedium => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Title Small
  TextStyle get titleSmall => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Label Large
  TextStyle get labelLarge => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Label Medium
  TextStyle get labelMedium => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text Label Small
  TextStyle get labelSmall => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text body Large
  TextStyle get bodyLarge => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text body Medium
  TextStyle get bodyMedium => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme text body Small
  TextStyle get bodySmall => copyWith(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  // *******************************************************************

  /// [TextStyle]
  /// Function TextStyle copyWith theme Shadow custom
  TextStyle get shadowBlack => copyWith(
    shadows: [
      Shadow(color: Colors.black, offset: Offset(1, 0)),
      Shadow(color: Colors.black, offset: Offset(0, 1)),
      Shadow(color: Colors.black, offset: Offset(-1, 0)),
      Shadow(color: Colors.black, offset: Offset(0, -1)),
    ],
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme Shadow custom
  TextStyle get shadowWhite => copyWith(
    shadows: [
      Shadow(color: Colors.white, offset: Offset(1, 0)),
      Shadow(color: Colors.white, offset: Offset(0, 1)),
      Shadow(color: Colors.white, offset: Offset(-1, 0)),
      Shadow(color: Colors.white, offset: Offset(0, -1)),
    ],
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme Shadow custom
  TextStyle get shadowGrey => copyWith(
    shadows: [
      Shadow(color: Colors.grey, offset: Offset(1, 0)),
      Shadow(color: Colors.grey, offset: Offset(0, 1)),
      Shadow(color: Colors.grey, offset: Offset(-1, 0)),
      Shadow(color: Colors.grey, offset: Offset(0, -1)),
    ],
  );

  /// [TextStyle]
  /// Function TextStyle copyWith theme Shadow custom
  TextStyle shadow(
    Color color, [
    double left = 1,
    double top = 1,
    double right = 1,
    double bottom = 1,
  ]) => copyWith(
    shadows: [
      Shadow(color: color, offset: Offset(left, 0)),
      Shadow(color: color, offset: Offset(0, top)),
      Shadow(color: color, offset: Offset(-right, 0)),
      Shadow(color: color, offset: Offset(0, -bottom)),
    ],
  );
}

RoundedRectangleBorder borderCard({
  BorderRadiusGeometry borderRadius = BorderRadius.zero,
  BorderSide side = BorderSide.none,
}) => RoundedRectangleBorder(borderRadius: borderRadius, side: side);

/// `GestureUnfocus` extend to [Widget]
/// * `unfocusW` return [Widget]
extension GestureUnfocus on Widget {
  /// If a [Widget] `TextField` or `TextFormField` exists then the entire parent
  /// is wrapped to close the keyboard using only this extension.
  Widget get unfocusW {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: this,
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  //
  DateTime timeOfDayToDateTime({required DateTime dateTime}) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, hour, minute);
  }
}

// decoraciones para tarjetas
class DecorationCustom {
  /// decoraciones para tarjetas
  static BoxDecoration decorationCard({Color? color, double radius = 20.0}) =>
      BoxDecoration(borderRadius: BorderRadius.circular(radius), color: color);

  /// decoraciones de TextFields
  static OutlineInputBorder decoEditText1({
    double radius = 0.0,
    Color colorBorder = const Color(0xFF000000),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: colorBorder, style: BorderStyle.none),
    );
  }
}

extension StyleFonts on TextStyle {
  /// get font in GoogleFonts library or style default
  TextStyle gFonts([String? fontText, double? fontSizeText]) {
    String fontFamily = fontText ?? '';

    if (fontFamily.isEmpty) return this;

    if (fontFamily.contains("_regular")) {
      fontFamily = fontFamily.replaceAll("_regular", "");
    }

    if (!GoogleFonts.asMap().containsKey(fontFamily)) {
      debugPrint('CustomTextTheme.gFonts: Font $fontFamily not found...');
      return copyWith(fontFamily: fontFamily);
    }

    try {
      return GoogleFonts.getFont(
        fontFamily,
        fontSize: fontSizeText ?? fontSize,
        height: height,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        fontWeight: fontWeight,
        locale: locale,
        shadows: shadows,
        decoration: decoration,
        color: color,
        backgroundColor: backgroundColor,
        background: background,
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      return this;
    }
  }
}
