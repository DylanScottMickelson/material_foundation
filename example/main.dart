import 'package:flutter/material.dart';
import 'package:material_foundation/dynamic_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '🏗️ Material Foundation',
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  //Card Example : Widget Build Method
  Widget _card(Color color) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Card(color: color, child: const SizedBox(height: 69)),
    );
  }

  //Cards List : Widget List
  List<Widget> _cards(String type) {
    return [
      Padding(
        padding: const EdgeInsets.all(13),
        child: Center(
          child: Text(
            type,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
          ),
        ),
      ),
      _card(Colors.red),
      _card(Colors.yellow),
      _card(Colors.green),
    ];
  }

  //Mobile Body : Widget Build Method
  Widget _mobile() {
    return ListView(children: _cards("Mobile"));
  }

  //Tablet Body : Widget Build Method
  Widget _tablet() {
    return GridView.count(crossAxisCount: 2, children: _cards("Tablet"));
  }

  //Desktop Body : Widget Build Method
  Widget _desktop() {
    return GridView.count(crossAxisCount: 3, children: _cards("Desktop"));
  }

  //Adpative Screen : Widget Build Method
  Widget _screen() {
    return DynamicScaffold(
      backgroundColor: Colors.blueAccent,
      mobileBody: _mobile(),
      tabletBody: _tablet(),
      desktopBody: _desktop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _screen();
  }
}
