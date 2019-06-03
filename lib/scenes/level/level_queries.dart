import 'package:flutter/material.dart';

class SingleQuery {
  int input, output;
  SingleQuery(this.input, this.output);
}

class LevelQueriesList extends StatelessWidget {

  final List<SingleQuery> questions;

  LevelQueriesList({ this.questions });

  @override
  Widget build(BuildContext context) => ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: questions.length,
    itemBuilder: (context, index) {
      final ask = questions[index];
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('${ask.input}'),
            Icon(Icons.arrow_forward),
            Text('${ask.output}'),
          ],
        ),
      );
    }
  );
}
