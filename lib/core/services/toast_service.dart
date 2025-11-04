import 'package:flutter/material.dart';

import 'package:toastification/toastification.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'check_platform.dart';

/// ToastGravity
/// Used to define the position of the Toast on the screen
enum Gravity {
  top,
  bottom,
  center,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  centerLeft,
  centerRight,
  snackbar,
  none,
}

class ToastService {
  static final ToastService _instance = ToastService._internal();
  static late Toastification toastification;

  factory ToastService() {
    toastification = Toastification();
    return _instance;
  }

  ToastService._internal();

  /// Only Mobile
  static final _toastService = ToastService();

  /// Toast multiple devices
  static toast(
    String msg, {
    toastLength = Toast.LENGTH_SHORT,
    Gravity gravity = Gravity.center,
    timeInSecForIosWeb = 1,
    backgroundColor = Colors.black54,
    textColor = Colors.white,
    fontSize = 16.0,
  }) {
    if (!CheckPlatform.isModeMobile) {
      _toastService.showCustomToast(
        titleCustom: msg,
        title: Text(msg),
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
      );
      return;
    }
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: ToastGravity.values[gravity.index],
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  void showSuccessToast(String message, {Duration? duration}) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: Text(message),
      autoCloseDuration: duration ?? const Duration(seconds: 3),
    );
  }

  void showErrorToast(String message, {Duration? duration}) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: Text(message),
      autoCloseDuration: duration ?? const Duration(seconds: 3),
    );
  }

  void showInfoToast(String message, {Duration? duration}) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      title: Text(message),
      autoCloseDuration: duration ?? const Duration(seconds: 3),
    );
  }

  void showWarningToast(String message, {Duration? duration}) {
    toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.flat,
      title: Text(message),
      autoCloseDuration: duration ?? const Duration(seconds: 3),
    );
  }

  void showCustomToast({
    BuildContext? context,
    OverlayState? overlayState,
    AlignmentGeometry? alignment,
    Duration? autoCloseDuration,
    Duration? animationDuration,
    Widget Function(BuildContext, Animation<double>, Alignment, Widget)?
    animationBuilder,
    ToastificationType? type,
    ToastificationStyle? style,
    Widget? title,
    String titleCustom = '',
    Widget? description,
    Widget? icon,
    IconData iconCustom = Icons.info_outline,
    Color? primaryColor,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    List<BoxShadow>? boxShadow,
    TextDirection? direction,
    bool? showProgressBar,
    ProgressIndicatorThemeData? progressBarTheme,
    CloseButtonShowType? closeButtonShowType,
    ToastCloseButton closeButton = const ToastCloseButton(),
    bool? closeOnClick,
    bool? dragToClose,
    bool? showIcon,
    DismissDirection? dismissDirection,
    bool? pauseOnHover,
    bool? applyBlurEffect,
    ToastificationCallbacks callbacks = const ToastificationCallbacks(),
  }) {
    toastification.show(
      context: context,
      overlayState: overlayState,
      alignment: alignment,
      autoCloseDuration: autoCloseDuration,
      animationDuration: animationDuration,
      animationBuilder: animationBuilder,
      type:
          type ??
          ToastificationType.custom(
            titleCustom,
            backgroundColor ?? Colors.black38,
            iconCustom,
          ),
      style: style,
      title: title,
      description: description,
      icon: icon,
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      borderSide: borderSide,
      boxShadow: boxShadow,
      direction: direction,
      showProgressBar: showProgressBar,
      progressBarTheme: progressBarTheme,
      // ignore: deprecated_member_use
      closeButtonShowType: closeButtonShowType,
      closeButton: closeButton,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      showIcon: showIcon,
      dismissDirection: dismissDirection,
      pauseOnHover: pauseOnHover,
      applyBlurEffect: applyBlurEffect,
      callbacks: callbacks,
    );
  }
}
