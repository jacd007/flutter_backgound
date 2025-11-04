import 'package:flutter/material.dart';

class PopScopeWidget extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  const PopScopeWidget(
      {this.child, this.width, this.height, this.constraints, super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        debugPrint('didPop: $didPop');
      },
      child: Container(
        width: width,
        height: height,
        constraints: constraints,
        child: Center(
          child: child ??
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.logout)),
        ),
      ),
    );
  }
}
