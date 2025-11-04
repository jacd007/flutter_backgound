import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// Indicates if snack is going to start at the [TOP] or at the [BOTTOM]
enum SnackPositions { top, bottom }

class DoubleBackToExit extends StatefulWidget {
  const DoubleBackToExit({
    super.key,
    required this.snackBarTitle,
    required this.snackBarMessage,
    required this.child,
    this.onDoubleBack,
    this.doubleBackDuration = const Duration(milliseconds: 1350),
    this.snackbarBackgroundColor = Colors.black54,
    this.snackbarTextColor = Colors.white,
    this.icon,
    this.snackbarMargin,
    this.snackbarPadding,
    this.snackbarWidth,
    this.enabled = true,
    this.snackPositions = SnackPositions.bottom,
  });
  final Widget child;
  final String snackBarTitle;
  final String snackBarMessage;
  final FutureOr<bool> Function()? onDoubleBack;
  final Duration doubleBackDuration;

  final Color snackbarBackgroundColor;
  final Color snackbarTextColor;
  final Widget? icon;
  final EdgeInsets? snackbarMargin;
  final EdgeInsets? snackbarPadding;
  final double? snackbarWidth;
  final bool enabled;
  final SnackPositions snackPositions;

  @override
  State<DoubleBackToExit> createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    // * Web
    if (kIsWeb || !widget.enabled) return widget.child;

    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();

      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > widget.doubleBackDuration) {
        currentBackPressTime = now;
        Get.snackbar(
          widget.snackBarTitle,
          widget.snackBarMessage,
          duration: widget.doubleBackDuration,
          backgroundColor: widget.snackbarBackgroundColor,
          margin: widget.snackbarMargin,
          padding: widget.snackbarPadding,
          maxWidth: widget.snackbarWidth,
          colorText: widget.snackbarTextColor,
          snackPosition: SnackPosition.values[widget.snackPositions.index],
          icon: widget.icon,
        );

        return false;
      }

      if (widget.onDoubleBack != null) return await widget.onDoubleBack!();

      return true;
    }

    // * Android
    if (Platform.isAndroid) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: onWillPop,
        child: widget.child,
      );
    }

    // * IOS
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) async {
          if (details.delta.dx > 8) await onWillPop();
        },
        child: widget.child,
      ),
    );
  }
}
