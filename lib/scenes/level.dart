import 'package:flutter/material.dart';

class Level extends StatelessWidget {

  final String name;
  final ValueChanged<bool> onSolve;

  // todo: pass entire LevelModel to interact with
  //       or, alternatively, create whole levelsolver 
  //       to interact with
  Level({ Key key, @required this.name, this.onSolve });

  @override 
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Level $name'),
    ),
    body: Center(
      // todo: provide proper ui & logic there
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('solve'),
            onPressed: () => onSolve(true),
          ),
          FlatButton(
            child: Text('unsolve'),
            onPressed: () => onSolve(false),
          ),
        ],
      ),
    ),
  );
}