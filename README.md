# 🏗️ Material Foundation

A foundation for adaptive flutter material apps.

This plugin supports adaptive screen scaffolding; allowing you to change which widget is shown on a screen, based off
the screen size (Desktop, Tablet, or Mobile).

## ✨ Get Started

Create a folder named ```packages``` in your flutter project.

Paste ```material_foundation``` package in the ```packages``` folder.

Add ```material_foundation``` as a dependency in your ```pubspec.yaml``` file:

```dart
dependencies:
  flutter:
    sdk: flutter

  material_foundation:
    path: packages/material_foundation/
```

Run ```flutter pub get``` to fetch the package and its dependencies.

## Usage

Import the Material Foundation library files into your Dart file:

```dart
import 'package:material_foundation/adaptive_scaffold.dart';
import 'package:material_foundation/adaptive_layout_builder.dart';
```


Create a new AdaptiveScaffold widget with the desired layouts for desktop, tablet, and mobile devices:

```dart
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Foundation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  AdaptiveScaffold(
          backgroundColor: Colors.white,
          desktopBody: DesktopBody(),
          tabletBody: TabletBody(),
          mobileBody: MobileBody(),
        ),
    );
  }
}
```

Create separate widgets for the desktop, tablet, and mobile layouts. These widgets will be displayed according to their respective screen sizes:

```dart
class DesktopBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Desktop Body');
  }
}

class TabletBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Tablet Body');
  }
}

class MobileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Mobile Body');
  }
}
```

## 👐 Contributing
We welcome contributions from the community! If you'd like to contribute, please check out our contribution guidelines and submit a pull request with your changes.

## 📃 License
Material Foundation is released under the BSD-3 License. See LICENSE for details.
