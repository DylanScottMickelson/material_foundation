import 'package:flutter/material.dart';

class AdaptiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext, Orientation, BoxConstraints) builder;
  const AdaptiveLayoutBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return LayoutBuilder(builder: (context, constraints) {
      return builder(context, orientation, constraints);
    });
  }
}
