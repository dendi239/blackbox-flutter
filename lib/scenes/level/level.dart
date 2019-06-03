import 'package:flutter/material.dart';
import 'package:blackbox/model/level.dart';

import 'level_query.dart';
import 'level_queries.dart';
import 'solve.dart';

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
          onPressed: () => showDialog(
            context: context,
            builder: (context) => SolveWidget(
              level: level,
              solveTriesCount: 3,
              onSolve: onSolve,
            ),
          ),
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
          child: LevelQueriesList(questions: queries),
        ),
      ],
    ),
  );
}
