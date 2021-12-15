import 'package:flutter/material.dart';

enum ScreenSizes { small, medium, large }

class ScreenSize {
  static ScreenSizes _getSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width <= 600) return ScreenSizes.small;
    if (width > 600 && width <= 900) return ScreenSizes.medium;
    return ScreenSizes.large;
  }

  static bool isSmall(BuildContext context) =>
      _getSize(context) == ScreenSizes.small;

  static bool isMedium(BuildContext context) =>
      _getSize(context) == ScreenSizes.medium;

  static bool isLarge(BuildContext context) =>
      _getSize(context) == ScreenSizes.large;

  static EdgeInsets minPadding(BuildContext context) => EdgeInsets.only(
        top: !isSmall(context) ? 20.0 : 0.0,
        bottom: 3.0,
        left: !isSmall(context) ? 30.0 : 0.0,
        right: !isSmall(context) ? 30.0 : 0.0,
      );
}
