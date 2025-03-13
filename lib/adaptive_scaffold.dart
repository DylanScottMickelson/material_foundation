import 'package:flutter/material.dart';
import 'package:material_foundation/adaptive_layout_builder.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Color backgroundColor;
  final Widget desktopBody;
  final Widget tabletBody;
  final Widget mobileBody;

  const AdaptiveScaffold({
    super.key,
    required this.backgroundColor,
    required this.desktopBody,
    required this.tabletBody,
    required this.mobileBody,
  });

  //Scaffold Body : Widget Build Method
  Widget _buildScaffoldBody(BuildContext context) {
    return AdaptiveLayoutBuilder(builder: (context, orientation, constraints) {
      switch (orientation) {
        case Orientation.landscape:
          if (constraints.maxWidth > 1200) {
            return desktopBody;
          } else if (constraints.maxWidth < 1200 &&
              constraints.maxWidth > 720) {
            return tabletBody;
          } else {
            return mobileBody;
          }
        case Orientation.portrait:
          if (constraints.maxHeight > 720) {
            return desktopBody;
          } else if (constraints.maxWidth > 600) {
            return tabletBody;
          } else {
            return mobileBody;
          }
        default:
          throw UnimplementedError('Unsupported orientation: $orientation');
      }
    });
  }

  //Scaffold Screen : Widget Build Method
  Widget _buildScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: _buildScaffoldBody(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context);
  }
}
