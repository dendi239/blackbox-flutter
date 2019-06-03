import 'package:flutter/material.dart';

import 'scenes/levels_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'blackbox game',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Blackbox'),
        // todo: add info button here
      ),
      body: LevelListWidget(),
    ),
  );
}