import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_foundation/dynamic_layout_builder.dart';

const _mobileKey = ValueKey<String>('mobile');
const _tabletKey = ValueKey<String>('tablet');
const _desktopKey = ValueKey<String>('desktop');

Widget _layoutBuilder({
  double? width,
  double? maxMobileWidth,
  double? maxTabletWidth,
  double? minDesktopWidth,
}) {
  return MaterialApp(
    home: DynamicLayoutBuilder(
      const SizedBox(key: _mobileKey),
      const SizedBox(key: _tabletKey),
      const SizedBox(key: _desktopKey),
      width: width,
      maxMobileWidth: maxMobileWidth,
      maxTabletWidth: maxTabletWidth,
      minDesktopWidth: minDesktopWidth,
    ),
  );
}

void _expectOnly(ValueKey<String> expectedKey) {
  for (final key in [_mobileKey, _tabletKey, _desktopKey]) {
    expect(find.byKey(key), key == expectedKey ? findsOneWidget : findsNothing);
  }
}

void main() {
  group('DynamicLayoutBuilder', () {
    testWidgets('uses the default breakpoint boundaries', (tester) async {
      final cases = <(double, ValueKey<String>)>[
        (739, _mobileKey),
        (740, _tabletKey),
        (1199, _tabletKey),
        (1200, _desktopKey),
      ];

      for (final (width, expectedKey) in cases) {
        await tester.pumpWidget(_layoutBuilder(width: width));
        _expectOnly(expectedKey);
      }
    });

    testWidgets('honors custom tablet and desktop breakpoints', (tester) async {
      final cases = <(double, ValueKey<String>)>[
        (599, _mobileKey),
        (600, _tabletKey),
        (999, _tabletKey),
        (1000, _desktopKey),
      ];

      for (final (width, expectedKey) in cases) {
        await tester.pumpWidget(
          _layoutBuilder(
            width: width,
            maxMobileWidth: 600,
            maxTabletWidth: 800,
            minDesktopWidth: 1000,
          ),
        );
        _expectOnly(expectedKey);
      }
    });

    testWidgets('explicit width overrides the available layout width', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(500, 800);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(_layoutBuilder(width: 1200));

      _expectOnly(_desktopKey);
    });

    testWidgets('rebuilds when the available width crosses breakpoints', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(500, 800);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(_layoutBuilder());
      _expectOnly(_mobileKey);

      tester.view.physicalSize = const Size(800, 800);
      await tester.pump();
      _expectOnly(_tabletKey);

      tester.view.physicalSize = const Size(1300, 800);
      await tester.pump();
      _expectOnly(_desktopKey);
    });
  });
}
