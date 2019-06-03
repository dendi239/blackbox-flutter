import 'package:blackbox/model/level.dart';
import 'package:flutter/material.dart';

class SingleQuery {
  int input, output;
  SingleQuery(this.input, this.output);
}

class LevelTries extends StatelessWidget {

  final List<SingleQuery> questions;

  LevelTries({ this.questions });

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

class Level extends StatefulWidget {

  final LevelModel level;
  final ValueChanged<bool> onSolve;

  Level({ Key key, this.level, this.onSolve });

  @override 
  State<StatefulWidget> createState() => _LevelState(
    key: key,
    level: level,
    onSolve: onSolve,
  );
}

class _LevelState extends State<Level> {

  final LevelModel level;
  final ValueChanged<bool> onSolve;

  List<SingleQuery> queries = [];

  _LevelState({ Key key, this.level, this.onSolve });

  @override 
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Level ${level.name}'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () => onSolve(true),
        ),
      ],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: LevelQueryWidget((query) => setState(() {
            final result = level.ask(query);
            queries.add(SingleQuery(query, result));
          })),
        ),
        Flexible(
          child: LevelTries(questions: queries),
        ),
      ],
    ),
  );
}
