import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../features/features_m.dart';
import '../core_m.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final routes = Get.put(AuthController());
  late Timer timer;
  bool showHelp = false;

  @override
  void initState() {
    _initCounter();

    super.initState();
  }

  void _initCounter() {
    timer = Timer(const Duration(seconds: 120), _onShowHelper);
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        desktopScreen: Center(child: _buildBody()),
        mobileScreen: _buildBody(),
      ),
      bottomSheet: showHelp
          ? Container(
              height: 60,
              color: Colors.white,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    _initCounter();
                    setState(() => showHelp = false);

                    routes.isAuthenticated();
                  },
                  child: Text(
                    Tk.update.tr,
                    style: style.bold.forceBlackColor.italic,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  void _onShowHelper() {
    debugPrint('onShowHelper');
    setState(() {
      showHelp = true;
    });
  }

  Widget _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                image: DecorationImage(
                  image: Image.asset(
                    Assets.logoSplash,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.error, size: 60.0),
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 0,
          right: 0,
          child: Center(
            child: showHelp
                ? Text(
                    Tk.pageMsgErrorInit.tr,
                    style: style.autoColor(AppColors.error).italic,
                  )
                : CustomAnimatedLoading(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
