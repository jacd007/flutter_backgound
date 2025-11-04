import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? desktopScreen;
  final Widget? mobileScreen;
  final double maxScreenWidth;

  const ResponsiveWidget({
    super.key,
    this.desktopScreen,
    this.mobileScreen,
    this.maxScreenWidth = 530.0,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > maxScreenWidth) {
      return desktopScreen ?? mobileScreen ?? const SizedBox();
    }

    return mobileScreen ?? desktopScreen ?? const SizedBox();
  }
}

/* class ResponsiveWidget extends StatelessWidget {
  final Widget? desktopScreen;
  //final Widget? tabletScreen;
  final Widget? mobileScreen;
  //final Widget? replyWidget;
  //final bool hasTabletAndDesktop;

  const ResponsiveWidget({
    Key? key,
    this.desktopScreen,
    //this.tabletScreen,
    this.mobileScreen,
    //this.replyWidget,
    //this.hasTabletAndDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    /* if (replyWidget != null) return replyWidget!;
    if (hasTabletAndDesktop) {
      return tabletScreen ?? desktopScreen ?? mobileScreen!;
    } */

    if (screenWidth > 950) {
      return desktopScreen /* ?? tabletScreen */ ?? mobileScreen!;
    }
    if (screenWidth > 600) {
      return /* tabletScreen ?? */ mobileScreen ?? desktopScreen!;
    }

    return mobileScreen /* ?? tabletScreen */ ?? desktopScreen!;
  }
} */
