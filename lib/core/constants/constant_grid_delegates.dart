import 'package:flutter/material.dart';

///
/// [childAspectRatio] width / height
///
class ConstantGridDelegates {
  ConstantGridDelegates._();

  static const aspectCard = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 180.0,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 0.695,
  );

  static const aspectCard2 = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 190.0,
    mainAxisSpacing: 5.0,
    crossAxisSpacing: 5.0,
    childAspectRatio: 4 / 5,
  );

  static const aspectCard3 = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 140.0,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 1 / 2,
  );

  static const crossAxisCount2 = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 3 / 4,
  );

  static const crossAxisCount = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.695,
  );

  static const crossAxisSquareCount = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
  );

  static const cross20AxisSquareCount =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12.0,
    crossAxisSpacing: 12.0,
    childAspectRatio: 0.85,
  );

  static const aspectSquare = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 1.0,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  );

  static const aspectRectRectangle = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200.0,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 5 / 3,
  );
}
