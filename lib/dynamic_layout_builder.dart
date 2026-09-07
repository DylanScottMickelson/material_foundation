import 'package:flutter/material.dart';

/// Dynamic Layout Builder Widget
///
/// Takes in three widgets (mobile, tablet, desktop)
/// Changes the widget built based off screen size.
///
/// Creator: Dylan Scott Mickelson
/// Date: 01/13/2019
/// Edited:
/// 01/09/2026 DSM
/// 09/07/2026 DSM

class DynamicLayoutBuilder extends StatelessWidget {
  final Widget mobileWidget;
  final Widget tabletWidget;
  final Widget desktopWidget;
  final double? width;
  final double? maxDesktopWidth;
  final double? maxTabletWidth;

  const DynamicLayoutBuilder(
    this.mobileWidget,
    this.tabletWidget,
    this.desktopWidget, {
    this.width,
    this.maxTabletWidth,
    this.maxDesktopWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if ((width ?? constraints.maxWidth) >= (1200)) {
          return desktopWidget;
        } else if ((width ?? constraints.maxWidth) >= (maxTabletWidth ?? 740) &&
            (width ?? constraints.maxWidth) < (maxDesktopWidth ?? 1200)) {
          return tabletWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}
