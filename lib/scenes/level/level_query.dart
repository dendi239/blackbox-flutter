import 'package:flutter/material.dart';

class LevelQueryWidget extends StatelessWidget {
  
  num number;
  final Function(num) query;

  LevelQueryWidget(this.query);

  @override 
  Widget build(BuildContext context) => ListTile(
    title: TextField(
      autofocus: true,
      keyboardAppearance: Theme.of(context).brightness,
      keyboardType: TextInputType.number,
      onChanged: (text) => number = num.parse(text),
      onSubmitted: (text) {
        number = num.parse(text);
        if (number != null) {
          query(number);
        }
      },
    ),
    trailing: IconButton(
      icon: Icon(Icons.search),
      onPressed: () => query(number),
    ),
  );
}