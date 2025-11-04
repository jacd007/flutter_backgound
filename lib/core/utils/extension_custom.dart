// ignore_for_file: no_wildcard_variable_uses

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

extension StringExtension2 on String {
  /// capitalize string
  String toCapitalizes() {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// capitalize each word
  String toCapitalizeEachWord() {
    // ignore: unnecessary_this
    return this
        .split(' ')
        .map((word) {
          if (word.isEmpty) {
            return '';
          }
          return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
        })
        .join(' ');
  }

  /// auto complete url
  String get autoCompleteURL {
    String url = this;
    if (!url.startsWith("http")) url = 'https://$url';
    return url;
  }

  /// format pad left
  String setHide({int maxVisible = 2, String padding = '*', bool hide = true}) {
    String value = this;
    int width = value.length;

    if (hide) value = value.substring(width - maxVisible);

    final left = value.padLeft(width - maxVisible, padding);
    return left;
  }

  /// parse `String` to `int`.
  /// returns `-1` if it cannot parse the `string`
  int get toInteger {
    try {
      return int.parse(this);
    } catch (_) {
      return -1;
    }
  }

  /// parse `String` to `double`.
  /// returns `-1` if it cannot parse the `string`
  double get toDouble {
    try {
      return double.parse(this);
    } catch (_) {
      return -1;
    }
  }

  /// decode list
  List<T> toDecode<T>() {
    try {
      return json.decode(this) as List<T>;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Color toColor([Color defaultColor = Colors.black]) {
    try {
      String code = length <= 7 ? replaceAll("#", "#FF") : this;
      code = code.contains("#") ? code : "#$code";
      final color = Color(int.parse(code.substring(1), radix: 16) + 0x00000000);
      return color;
    } catch (_) {
      return defaultColor;
    }
  }

  /// capitalize string
  String capitalizes() {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// capitalize each word
  String capitalizeEachWord() {
    // ignore: unnecessary_this
    return this
        .split(' ')
        .map((word) {
          if (word.isEmpty) {
            return '';
          }
          return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
        })
        .join(' ');
  }

  String get snakeCaseToCamelCase {
    if (isEmpty) {
      return '';
    }
    // Si la cadena ya es camelCase, no hacer nada
    if (!contains('_')) {
      return this;
    }
    return replaceAll("-", "_").replaceAll(" ", "_").split('_').reduce((
      acc,
      element,
    ) {
      return acc + element[0].toUpperCase() + element.substring(1);
    });
  }

  // Convierte  camelCase a snake_case
  String get camelCaseToSnakeCase {
    if (isEmpty) {
      return '';
    }

    // Use a regular expression to find uppercase letters
    // and insert an underscore before them, then convert to lowercase.
    return replaceAll("-", "_")
        .replaceAll(" ", "_")
        .replaceAllMapped(
          RegExp(
            r'(?<=[a-z])(?=[A-Z])',
          ), // Look for an uppercase letter preceded by a lowercase letter
          (Match match) => '_',
        )
        .toLowerCase();
  }

  bool isBase64() {
    final RegExp base64RegExp = RegExp(
      r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$',
    );
    return base64RegExp.hasMatch(this);
  }

  bool get isVideo {
    return endsWith(".mp4") ||
        endsWith(".mov") ||
        endsWith(".mkv") ||
        endsWith(".avi") ||
        endsWith(".webm") ||
        endsWith(".wmv") ||
        endsWith(".flv") ||
        endsWith(".avchd") ||
        endsWith(".mts") ||
        endsWith(".m2ts") ||
        endsWith(".3gp");
  }

  bool get isUrlYouTube {
    try {
      final uri = Uri.parse(this);
      if (!uri.isAbsolute) return false;

      // Comprobar dominio
      if (!(uri.host.contains('youtube.com') ||
          uri.host.contains('youtu.be'))) {
        return false;
      }

      // Comprobar tipo de video
      if (uri.host.contains('youtu.be')) {
        // URL corta, ejemplo: youtu.be/ID
        return true;
      }

      if (uri.pathSegments.isNotEmpty) {
        if (uri.pathSegments[0] == 'watch') {
          // Video normal con ?v=ID
          if (uri.queryParameters.containsKey('v')) {
            return true;
          }
        } else if (uri.pathSegments[0] == 'shorts') {
          // Shorts
          return true;
        }
        // Aquí se pueden agregar otros patrones para música
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}

/// [DateTime] on text format simple
/// FORMAT1 is `yyyy/MM/dd`
extension DateTimeExtension on DateTime {
  /// FORMAT1 is `yyyy/MM/dd`
  String toFormat1([String formate = 'dd/MM/yyyy', String? locale]) {
    var format = DateFormat(formate, locale);
    var dateResult = format.format(this);
    return dateResult;
  }

  ///
  TimeOfDay toTimeOfDay() {
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(this);
    return timeOfDay;
  }

  //
  List<String> get getAllMonths {
    final list = List.generate(
      12,
      (i) => DateTime(year, i + 1).toFormat1('MMMM').capitalizes(),
    );

    return list;
  }

  //
  List<String> get getAllDays {
    List<String> days = [];
    DateTime date = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime weekdayDate = date.add(Duration(days: i - date.weekday + 1));
      String dayName = weekdayDate.toFormat1('EEEE').capitalizes();
      days.add(dayName);
    }

    return days;
  }

  /// return true if `year` is leap year
  /// (Bisiesto)
  bool isLeapYear([DateTime? date]) {
    final age = date?.year ?? year;
    return (age % 4 == 0 && age % 100 != 0) || (age % 400 == 0);
  }

  //
  DateTime getLastDayOfMonth([DateTime? date]) {
    final d = date ?? this;
    DateTime firstDayOfMonthNext = DateTime(d.year, d.month + 1, 1);

    return firstDayOfMonthNext.subtract(const Duration(days: 1));
  }

  //
  DateTime getDateFirst([DateTime? date]) {
    final d = date ?? this;
    DateTime first = d.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    return first;
  }

  //
  DateTime getDateLast([DateTime? date]) {
    final d = date ?? this;
    DateTime last = d.copyWith(
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
    );

    return last;
  }
}

extension MapExtension2 on Map {
  /// Generate String Query from JsonQuery
  String get queryFromJson {
    String query = '';

    for (int i = 0; i < keys.length; i++) {
      if (i == 0) query += '?${keys.first}=${values.first}';
      if (i != 0) query += '&${keys.elementAt(i)}=${values.elementAt(i)}';
    }
    return query;
  }
}

/// Parse list integer to String with or without spaces, remove "[" and "]"
extension ParseListToString<T> on List<T> {
  String listToString([bool removeSpaces = false]) {
    String value = '$this'.replaceAll("[", "").replaceAll("]", "");
    if (removeSpaces) value = value.replaceAll(" ", "");
    return value;
  }
}

/// Hexadecimal to Color and reverse
extension HexColors on Color {
  String toHexA([String defaultColor = '#FF000000']) {
    try {
      // ignore: deprecated_member_use
      return '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    } catch (_) {
      return defaultColor;
    }
  }
}

/// List method next or previous
extension ListExtensions on List {
  /// to next
  int toNext(int current, [bool keep = true]) {
    if ((current + 1) >= length) return keep ? 0 : current;

    return current++;
  }

  /// to previous
  int toPrevious(int current, [bool reverse = true]) {
    if ((current) < 0) return reverse ? length : current;

    return current--;
  }

  /// encode list
  String toEncode() {
    try {
      return json.encode(this);
    } catch (e) {
      debugPrint(e.toString());
      return "[]";
    }
  }

  List<T> getFilled<T>(int number, dynamic fill) {
    List<T> listFilled = List.from(this);

    while (listFilled.length < number) {
      listFilled.add(fill);
    }

    if (listFilled.length > number) {
      listFilled = listFilled.sublist(0, number);
    }

    return listFilled;
  }
}

extension ListExtensionsCustom<T> on List<T> {
  List<T> addElementWithRemove(T compare) {
    removeWhere((element) => (element == compare));
    add(compare);
    return this;
  }

  List<T> addAfterRemoved(T compare, bool Function(T) action) {
    removeWhere(action);
    add(compare);
    return this;
  }

  List<T> replaceElement(T compare, bool Function(T) action, [int start = 0]) {
    final index = indexWhere(action, start);
    this[index] = compare;
    return this;
  }
}

/* extension FilteredWidget<T> on List<T> {
  /// [searchList] This function finds all the elements of a list type [T],
  /// using the parameterized function [by] and return `List<T>`
  List<T> searchList({required bool Function(T) by}) {
    List<T> items = [];
    return items.where(by).toList();
  }
} */

extension FormatePriceExtension on double {
  /// [priceFormat] This function format a double value
  ///
  /// - [pattern] String pattern to format. Default is "#,##0.00" for decimal and "#,##0" for integer
  /// - [showSymbol] Show or not the symbol. Default is true
  /// - [showDecimal] Show or not the decimal part. Default is false
  /// - [symbol] String symbol. Default is '\$'
  /// - [locale] String locale. Default is the locale of the app
  ///
  /// Example:
  /// final price = 1234.56;
  /// final formatted = price.priceFormat();
  /// print(formatted); // Output: \$1,234.56
  String priceFormat({
    String? pattern,
    bool showSymbol = true,
    bool showDecimal = false,
    String symbol = '\$',
    String? locale,
  }) {
    //
    String newPattern = showDecimal ? "#,##0.00" : "#,##0";
    newPattern = pattern ?? newPattern;

    //
    double n = num.parse(toStringAsFixed(showDecimal ? 2 : 0)).toDouble();
    var ff = NumberFormat(newPattern, locale).format(n);

    final lang = locale ?? Get.locale?.languageCode ?? 'en';

    if (lang != 'en') {
      ff = ff.replaceAll(".", "|");
      ff = ff.replaceAll(",", ".");
      ff = ff.replaceAll("|", ",");
    }
    String resp = showSymbol ? "$symbol $ff" : ff;
    return resp;
  }

  /// Format a double value as a price.
  ///
  /// - [locale] String locale. Default is the locale of the app
  /// - [symbol] String symbol. Default is '\$ '
  ///
  /// Example:
  /// final price = 1234.56;
  /// final formatted = price.toPrice();
  /// print(formatted); // Output: \$ 1,234.56
  String toPrice({
    String? locale,
    String symbol = '\$ ',
    int? decimalDigits = 2,
  }) {
    final format = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    final result = format.format(this);
    if (result.endsWith(".00") || result.endsWith(".0")) {
      return result.substring(0, result.length - 3);
    }
    return result;
  }

  String engineerFormat([int digits = 1]) {
    // ignore: no_leading_underscores_for_local_identifiers
    int _pows(int exponent) {
      return math.pow(10, exponent).toInt();
    }

    final a = _pows(-18);
    final f = _pows(-15);
    final p = _pows(-12);
    final n = _pows(-9);
    final u = _pows(-6);
    final m = _pows(-3);
    final x = _pows(0);
    final K = _pows(3);
    final M = _pows(6);
    final G = _pows(9);
    final T = _pows(12);
    final P = _pows(15);
    final E = _pows(18);

    // if (this < 1) return '${this * 1000}m';
    if (this >= a && this < f) return '${(this * a).toStringAsFixed(digits)}a';

    if (this >= f && this < p) return '${(this * f).toStringAsFixed(digits)}f';

    if (this >= p && this < n) return '${(this * p).toStringAsFixed(digits)}p';

    if (this >= n && this < m) return '${(this * n).toStringAsFixed(digits)}n';

    if (this >= u && this < m) return '${(this * u).toStringAsFixed(digits)}u';

    if (this >= m && this < x) return '${(this * K).toStringAsFixed(digits)}m';

    if (this >= x && this < K) return toString();

    if (this >= K && this < M) return '${(this / K).toStringAsFixed(digits)}K';

    if (this >= M && this < G) return '${(this / M).toStringAsFixed(digits)}M';

    if (this >= G && this < T) return '${(this / G).toStringAsFixed(digits)}G';

    if (this >= T && this < P) return '${(this / T).toStringAsFixed(digits)}T';

    if (this >= P && this < E) return '${(this / P).toStringAsFixed(digits)}P';

    if (this >= E) return '${(this / P).toStringAsFixed(digits)}E';

    return toString();
  }
}

/// [DateTime] on text format simple
extension DateTimeExtensions on DateTime {
  /// this Formate is `yyyy/MM/dd`
  String toFormate({String formate = 'dd/MM/yyyy', String? locale}) {
    var format = DateFormat(formate, locale);
    var dateResult = format.format(this);
    return dateResult;
  }

  /// get parse to yyyy-MM-dd format
  String get toYYYYMMdd {
    final y = year.toString().padLeft(4, '0');
    final M = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');

    final value = "$y-$M-$d";
    return value;
  }

  /// Divide the value [DateTime] of the period by a thousand
  /// `millisecondsSinceEpoch`
  int get divideByThousand => millisecondsSinceEpoch ~/ 1000;
}

/// [int] on text any format
extension IntegerExtensions on int {
  /// format pad left
  String padValue({int width = 6, String padding = '0', bool isLeft = true}) {
    String value = '$this';
    final left = value.padLeft(width, padding);
    final right = value.padRight(width, padding);
    return isLeft ? left : right;
  }

  /// format pad left
  String setHide({int maxVisible = 2, String padding = '*', bool hide = true}) {
    String value = '$this';
    int width = value.length;

    if (hide) value = value.substring(width - maxVisible);

    final left = value.padLeft(width - maxVisible, padding);
    return left;
  }

  /// engineer format number
  String get toEngineerFormat {
    String value = toString();

    final convert = _engineerAux(value, 1);

    return convert;
  }

  /// engineer format number
  String toEngineerFormatAsFixed([int digits = 2]) {
    String value = toString();

    final convert = _engineerAux(value, digits);

    return convert;
  }

  _engineerAux(String value, int digits) {
    // ignore: no_leading_underscores_for_local_identifiers
    int _pows(int exponent) {
      return math.pow(10, exponent).toInt();
    }

    final a = _pows(-18);
    final f = _pows(-15);
    final p = _pows(-12);
    final n = _pows(-9);
    final u = _pows(-6);
    final m = _pows(-3);
    final x = _pows(0);
    final K = _pows(3);
    final M = _pows(6);
    final G = _pows(9);
    final T = _pows(12);
    final P = _pows(15);
    final E = _pows(18);

    // if (this < 1) return '${this * 1000}m';
    if (this >= a && this < f) return '${(this * a).toStringAsFixed(digits)}a';

    if (this >= f && this < p) return '${(this * f).toStringAsFixed(digits)}f';

    if (this >= p && this < n) return '${(this * p).toStringAsFixed(digits)}p';

    if (this >= n && this < m) return '${(this * n).toStringAsFixed(digits)}n';

    if (this >= u && this < m) return '${(this * u).toStringAsFixed(digits)}u';

    if (this >= m && this < x) return '${(this * K).toStringAsFixed(digits)}m';

    if (this >= x && this < K) return value;

    if (this >= K && this < M) return '${(this / K).toStringAsFixed(digits)}K';

    if (this >= M && this < G) return '${(this / M).toStringAsFixed(digits)}M';

    if (this >= G && this < T) return '${(this / G).toStringAsFixed(digits)}G';

    if (this >= T && this < P) return '${(this / T).toStringAsFixed(digits)}T';

    if (this >= P && this < E) return '${(this / P).toStringAsFixed(digits)}P';

    if (this >= E) return '${(this / P).toStringAsFixed(digits)}E';

    return value;
  }

  /// [isNotZero] is this `Integer` is not zero
  bool get isNotZero => this != 0;

  /// Divide the value [int] of the period by a thousand
  /// `millisecondsSinceEpoch`
  int get divideByThousand => this ~/ 1000;
}

extension DynamicExtensions on dynamic {
  /// parse `String` to `int`.
  /// returns `-1` if it cannot parse the `string`
  int get toInteger {
    try {
      return int.parse('$this');
    } catch (_) {
      return -1;
    }
  }

  /// parse `String` to `double`.
  /// returns `-1` if it cannot parse the `string`
  double get toDouble {
    try {
      return double.parse('$this');
    } catch (_) {
      return -1;
    }
  }

  /// parse `String` to `bool`.
  /// returns `false` if it cannot parse the `string`
  bool get toBool {
    try {
      return bool.parse('$this');
    } catch (_) {
      return false;
    }
  }

  /// parse `String` to `DateTime`.
  /// returns `null` if it cannot parse the `string`
  DateTime? get toDateTime {
    try {
      return DateTime.parse('$this');
    } catch (_) {
      return null;
    }
  }

  /// parse `String` to `Color`.
  /// returns `null` if it cannot parse the `string`
  Color? get toColor {
    try {
      return Color(int.parse('$this'));
    } catch (_) {
      return null;
    }
  }

  /// parse `String` to `Uri`.
  /// returns `null` if it cannot parse the `string`
  Uri? get toUri {
    try {
      return Uri.parse('$this');
    } catch (_) {
      return null;
    }
  }

  /// parse `String` to `Uri`.
  /// returns `null` if it cannot parse the `string`
  String? get toForceString {
    try {
      return '$this';
    } catch (_) {
      return null;
    }
  }
}

extension AnyOptionsWidgets on Widget {
  /// GestureDetector is close current focus
  Widget unfocusText() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: this,
    );
  }

  /// Apply radius to widget
  Widget radiusApply({
    Key? key,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    double? radius,
  }) {
    return ClipRRect(
      key: key,
      borderRadius: radius != null
          ? BorderRadius.circular(radius)
          : borderRadius,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  /// Apply space with SafeArea Widget
  Widget safeArea({
    Key? key,
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) {
    return SafeArea(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: this,
    );
  }

  /// GestureDetector Widget
  Widget gestureDetector({
    Key? key,
    void Function(TapDownDetails)? onTapDown,
    void Function(TapUpDetails)? onTapUp,
    void Function()? onTap,
    void Function()? onTapCancel,
    void Function()? onSecondaryTap,
    void Function(TapDownDetails)? onSecondaryTapDown,
    void Function(TapUpDetails)? onSecondaryTapUp,
    void Function()? onSecondaryTapCancel,
    void Function(TapDownDetails)? onTertiaryTapDown,
    void Function(TapUpDetails)? onTertiaryTapUp,
    void Function()? onTertiaryTapCancel,
    void Function(TapDownDetails)? onDoubleTapDown,
    void Function()? onDoubleTap,
    void Function()? onDoubleTapCancel,
    void Function(LongPressDownDetails)? onLongPressDown,
    void Function()? onLongPressCancel,
    void Function()? onLongPress,
    void Function(LongPressStartDetails)? onLongPressStart,
    void Function(LongPressMoveUpdateDetails)? onLongPressMoveUpdate,
    void Function()? onLongPressUp,
    void Function(LongPressEndDetails)? onLongPressEnd,
    void Function(LongPressDownDetails)? onSecondaryLongPressDown,
    void Function()? onSecondaryLongPressCancel,
    void Function()? onSecondaryLongPress,
    void Function(LongPressStartDetails)? onSecondaryLongPressStart,
    void Function(LongPressMoveUpdateDetails)? onSecondaryLongPressMoveUpdate,
    void Function()? onSecondaryLongPressUp,
    void Function(LongPressEndDetails)? onSecondaryLongPressEnd,
    void Function(LongPressDownDetails)? onTertiaryLongPressDown,
    void Function()? onTertiaryLongPressCancel,
    void Function()? onTertiaryLongPress,
    void Function(LongPressStartDetails)? onTertiaryLongPressStart,
    void Function(LongPressMoveUpdateDetails)? onTertiaryLongPressMoveUpdate,
    void Function()? onTertiaryLongPressUp,
    void Function(LongPressEndDetails)? onTertiaryLongPressEnd,
    void Function(DragDownDetails)? onVerticalDragDown,
    void Function(DragStartDetails)? onVerticalDragStart,
    void Function(DragUpdateDetails)? onVerticalDragUpdate,
    void Function(DragEndDetails)? onVerticalDragEnd,
    void Function()? onVerticalDragCancel,
    void Function(DragDownDetails)? onHorizontalDragDown,
    void Function(DragStartDetails)? onHorizontalDragStart,
    void Function(DragUpdateDetails)? onHorizontalDragUpdate,
    void Function(DragEndDetails)? onHorizontalDragEnd,
    void Function()? onHorizontalDragCancel,
    void Function(ForcePressDetails)? onForcePressStart,
    void Function(ForcePressDetails)? onForcePressPeak,
    void Function(ForcePressDetails)? onForcePressUpdate,
    void Function(ForcePressDetails)? onForcePressEnd,
    void Function(DragDownDetails)? onPanDown,
    void Function(DragStartDetails)? onPanStart,
    void Function(DragUpdateDetails)? onPanUpdate,
    void Function(DragEndDetails)? onPanEnd,
    void Function()? onPanCancel,
    void Function(ScaleStartDetails)? onScaleStart,
    void Function(ScaleUpdateDetails)? onScaleUpdate,
    void Function(ScaleEndDetails)? onScaleEnd,
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool trackPadScrollCausesScale = false,
    Offset trackPadScrollToScaleFactor = kDefaultTrackpadScrollToScaleFactor,
    Set<PointerDeviceKind>? supportedDevices,
  }) {
    return GestureDetector(
      key: key,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: onTap,
      onTapCancel: onTapCancel,
      onSecondaryTap: onSecondaryTap,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onDoubleTapDown: onDoubleTapDown,
      onDoubleTap: onDoubleTap,
      onDoubleTapCancel: onDoubleTapCancel,
      onLongPressDown: onLongPressDown,
      onLongPressCancel: onLongPressCancel,
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPressDown: onSecondaryLongPressDown,
      onSecondaryLongPressCancel: onSecondaryLongPressCancel,
      onSecondaryLongPress: onSecondaryLongPress,
      onSecondaryLongPressStart: onSecondaryLongPressStart,
      onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
      onSecondaryLongPressUp: onSecondaryLongPressUp,
      onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      onTertiaryLongPressDown: onTertiaryLongPressDown,
      onTertiaryLongPressCancel: onTertiaryLongPressCancel,
      onTertiaryLongPress: onTertiaryLongPress,
      onTertiaryLongPressStart: onTertiaryLongPressStart,
      onTertiaryLongPressMoveUpdate: onTertiaryLongPressMoveUpdate,
      onTertiaryLongPressUp: onTertiaryLongPressUp,
      onTertiaryLongPressEnd: onTertiaryLongPressEnd,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onForcePressStart: onForcePressStart,
      onForcePressPeak: onForcePressPeak,
      onForcePressUpdate: onForcePressUpdate,
      onForcePressEnd: onForcePressEnd,
      onPanDown: onPanDown,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onPanCancel: onPanCancel,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      dragStartBehavior: dragStartBehavior,
      trackpadScrollCausesScale: trackPadScrollCausesScale,
      trackpadScrollToScaleFactor: trackPadScrollToScaleFactor,
      supportedDevices: supportedDevices,
      child: this,
    );
  }

  /// Return [Theme] with [ThemeData] and [ThemeData.useMaterial3] set to [useMaterial3].
  ///
  /// If [useMaterial3] is null, then [ThemeData.useMaterial3] is the default value.
  ///
  /// This is a convenience method around [Theme].
  ///
  Widget themeDataMaterial3([bool useMaterial3 = true]) {
    return Theme(
      data: ThemeData(useMaterial3: useMaterial3),
      child: this,
    );
  }

  /// Return [Theme] with [ThemeData] set to [themeData].
  ///
  /// This is a convenience method around [Theme].
  ///
  Widget themeData(ThemeData themeData) {
    return Theme(data: themeData, child: this);
  }
}
