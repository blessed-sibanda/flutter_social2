import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

class ImprovedScrollingWrapper extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;
  const ImprovedScrollingWrapper({
    Key? key,
    required this.scrollController,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImprovedScrolling(
      scrollController: scrollController,
      enableMMBScrolling: true,
      enableKeyboardScrolling: true,
      enableCustomMouseWheelScrolling: true,
      keyboardScrollConfig: KeyboardScrollConfig(
        arrowsScrollAmount: 250.0,
        homeScrollDurationBuilder: (currentScrollOffset, minScrollOffset) {
          return const Duration(milliseconds: 100);
        },
        endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
          return const Duration(milliseconds: 2000);
        },
      ),
      customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
        scrollAmountMultiplier: 2.0,
      ),
      child: child,
    );
  }
}
