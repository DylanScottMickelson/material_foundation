import 'package:flutter/material.dart';

/// Dynamic Layout Builder Widget
///
/// Takes in three widgets (mobile, tablet, desktop)
/// Changes the widget built based off screen size.
///
/// Creator: Dylan Scott Mickelson
/// Date: 01/13/2019
/// Edited: 01/09/2026

class DynamicLayoutBuilder extends StatelessWidget {
  final Widget mobileWidget;
  final Widget tabletWidget;
  final Widget desktopWidget;

  const DynamicLayoutBuilder(
    this.mobileWidget,
    this.tabletWidget,
    this.desktopWidget, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktopWidget;
        } else if (constraints.maxWidth >= 740 && constraints.maxWidth < 1200) {
          return tabletWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}
