import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomAnimatedLoading extends StatelessWidget {
  final Color? color;
  final Color? leftDotColor;
  final Color? rightDotColor;
  final double size;
  final TypeAnimatedLoading typeAnimatedLoading;

  const CustomAnimatedLoading({
    this.typeAnimatedLoading = TypeAnimatedLoading.staggeredDotsWave,
    this.color,
    this.leftDotColor,
    this.rightDotColor,
    this.size = 75.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _listOfAnimations(
      color: color ?? Colors.grey,
      leftDotColor: leftDotColor ?? const Color(0xFF1A1A3F),
      rightDotColor: rightDotColor ?? const Color(0xFFEA3799),
      size: size,
    )[typeAnimatedLoading.index];

    /* return LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? Colors.grey,
      size: size,
    ); */
  }
}

enum TypeAnimatedLoading {
  waveDots,
  inkDrop,
  twistingDots,
  threeRotatingDots,
  staggeredDotsWave,
  fourRotatingDots,
  fallingDot,
  progressiveDots,
  discreteCircle,
  threeArchedCircle,
  bouncingBall,
  flickR,
  hexagonDots,
  beat,
  twoRotatingArc,
  horizontalRotatingDots,
  newtonCradle,
  stretchedDots,
  halfTriangleDot,
  dotsTriangle,
}

List<Widget> _listOfAnimations({
  Color color = Colors.white,
  Color leftDotColor = const Color(0xFF1A1A3F),
  Color rightDotColor = const Color(0xFFEA3799),
  double size = 100.0,
}) =>
    [
      LoadingAnimationWidget.waveDots(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.inkDrop(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.twistingDots(
        leftDotColor: leftDotColor,
        rightDotColor: rightDotColor,
        size: size,
      ),
      LoadingAnimationWidget.threeRotatingDots(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.staggeredDotsWave(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.fourRotatingDots(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.fallingDot(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.progressiveDots(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.discreteCircle(
        color: color,
        size: size,
        secondRingColor: leftDotColor,
        thirdRingColor: rightDotColor,
      ),
      LoadingAnimationWidget.threeArchedCircle(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.bouncingBall(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.flickr(
        leftDotColor: leftDotColor,
        rightDotColor: rightDotColor,
        size: size,
      ),
      LoadingAnimationWidget.hexagonDots(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.beat(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.twoRotatingArc(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.horizontalRotatingDots(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.newtonCradle(
        color: color,
        size: 2 * size,
      ),
      LoadingAnimationWidget.stretchedDots(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.halfTriangleDot(
        color: color,
        size: size,
      ),
      LoadingAnimationWidget.dotsTriangle(
        color: color,
        size: size,
      ),
    ];
