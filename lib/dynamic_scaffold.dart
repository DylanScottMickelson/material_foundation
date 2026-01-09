import 'package:flutter/material.dart';

import 'dynamic_layout_builder.dart';

/// Dynamic Scaffold (Screen / Page) Widget
///
/// Takes in three widgets (mobile, tablet, desktop)
/// Changes the widget built on the screen based off screen size.
///
/// Creator: Dylan Scott Mickelson
/// Date: 01/13/2019
/// Edited: 01/09/2026

class DynamicScaffold extends StatelessWidget {
  final Widget desktopBody;
  final Widget tabletBody;
  final Widget mobileBody;
  final Color backgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool? resizeToAvoidInset;

  const DynamicScaffold({
    super.key,
    required this.desktopBody,
    required this.tabletBody,
    required this.mobileBody,
    required this.backgroundColor,
    this.drawer,
    this.endDrawer,
    this.resizeToAvoidInset,
  });

  ///Dyanmic Screen Body : Widget Build Method
  Widget _buildDynamicScaffoldBody() {
    return DynamicLayoutBuilder(mobileBody, tabletBody, desktopBody);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidInset ?? false,
        backgroundColor: backgroundColor,
        drawer: drawer,
        endDrawer: endDrawer,
        body: _buildDynamicScaffoldBody(),
      ),
    );
  }
}
