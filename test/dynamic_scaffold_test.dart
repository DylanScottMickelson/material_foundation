import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_foundation/dynamic_scaffold.dart';

const _mobileKey = ValueKey<String>('mobile-body');
const _tabletKey = ValueKey<String>('tablet-body');
const _desktopKey = ValueKey<String>('desktop-body');

Widget _scaffold({
  required double width,
  Color backgroundColor = Colors.white,
  Widget? drawer,
  Widget? endDrawer,
  bool? resizeToAvoidInset,
}) {
  return MaterialApp(
    home: DynamicScaffold(
      width: width,
      backgroundColor: backgroundColor,
      drawer: drawer,
      endDrawer: endDrawer,
      resizeToAvoidInset: resizeToAvoidInset,
      mobileBody: const SizedBox(key: _mobileKey),
      tabletBody: const SizedBox(key: _tabletKey),
      desktopBody: const SizedBox(key: _desktopKey),
    ),
  );
}

void _expectOnly(ValueKey<String> expectedKey) {
  for (final key in [_mobileKey, _tabletKey, _desktopKey]) {
    expect(find.byKey(key), key == expectedKey ? findsOneWidget : findsNothing);
  }
}

void main() {
  group('DynamicScaffold', () {
    testWidgets('selects the body for each default breakpoint range', (
      tester,
    ) async {
      final cases = <(double, ValueKey<String>)>[
        (739, _mobileKey),
        (740, _tabletKey),
        (1199, _tabletKey),
        (1200, _desktopKey),
      ];

      for (final (width, expectedKey) in cases) {
        await tester.pumpWidget(_scaffold(width: width));
        _expectOnly(expectedKey);
      }
    });

    testWidgets('passes configuration to the underlying Scaffold', (
      tester,
    ) async {
      const drawer = SizedBox(key: ValueKey<String>('drawer'));
      const endDrawer = SizedBox(key: ValueKey<String>('end-drawer'));

      await tester.pumpWidget(
        _scaffold(
          width: 500,
          backgroundColor: Colors.blue,
          drawer: drawer,
          endDrawer: endDrawer,
          resizeToAvoidInset: true,
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, Colors.blue);
      expect(scaffold.drawer, same(drawer));
      expect(scaffold.endDrawer, same(endDrawer));
      expect(scaffold.resizeToAvoidBottomInset, isTrue);
      expect(find.byType(SafeArea), findsOneWidget);
      _expectOnly(_mobileKey);
    });

    testWidgets('does not resize for the keyboard by default', (tester) async {
      await tester.pumpWidget(_scaffold(width: 500));

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.resizeToAvoidBottomInset, isFalse);
    });
  });
}
