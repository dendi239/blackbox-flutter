import 'package:flutter/material.dart';
import 'package:blackbox/model/level.dart';

class SolveWidget extends StatefulWidget {

  final int solveTriesCount;
  final LevelModel level;
  final ValueChanged<bool> onSolve;

  SolveWidget({
    this.solveTriesCount,
    this.level,
    this.onSolve,
  });
  
  @override
  State<StatefulWidget> createState() => _SolveWidget(
    level: level,
    solveTriesCount: solveTriesCount,
    onSolve: onSolve,
  );
}

class _SolveWidget extends State<SolveWidget> {

  int tries = 1;
  int number, guess;
  final LevelModel level;
  final int solveTriesCount;
  final ValueChanged<bool> onSolve;

  _SolveWidget({ this.level, this.solveTriesCount, this.onSolve, }) {
    number = level.generate();
  }

  _onGuess() => setState(() {
    if (tries == solveTriesCount) {
      Navigator.of(context).pop();
      onSolve(true);
    } else {
      tries += 1;
      number = level.generate();
    }
  });

  _guess(num input, num output) => setState(() {
    final result = level.ask(input);
    if (result == output) {
      _onGuess();
    } else {
      onSolve(false);
    }
  });

  @override 
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Question $tries / $solveTriesCount'),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$number -> ?'),
            TextField(
              autofocus: true,
              keyboardAppearance: Theme.of(context).brightness,
              keyboardType: TextInputType.number,
              onChanged: (text) => guess = num.parse(text),
              onEditingComplete: () => _guess(number, guess),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Test'),
          onPressed: () => _guess(number, guess),
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
