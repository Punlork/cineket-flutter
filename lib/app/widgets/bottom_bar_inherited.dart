import 'package:flutter/material.dart';

class BottomBarInherited extends InheritedWidget {
  const BottomBarInherited({
    required this.showBottomBar,
    required this.hideBottomBar,
    required super.child,
    super.key,
  });

  final VoidCallback showBottomBar;
  final VoidCallback hideBottomBar;

  static BottomBarInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BottomBarInherited>();
  }

  @override
  bool updateShouldNotify(covariant BottomBarInherited oldWidget) {
    return false;
  }
}
