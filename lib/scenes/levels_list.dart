import 'package:flutter/material.dart';

import 'package:blackbox/model/level.dart';
import 'level/level.dart';

class LevelListWidget extends StatefulWidget {

  // todo: get (or inject) levels somehow
  final List<LevelModel> list = [
    SimpleLevelModel('1', '1st lvl', (number) => number + 1),
    SimpleLevelModel('2', '2nd lvl', (number) => number ~/ 3 + 1),
    SimpleLevelModel('3', '3rd lvl', null),
    SimpleLevelModel('4', '4th lvl', null),
    SimpleLevelModel('5', '5th lvl', null),
  ];

  final Set<LevelModel> completedList = Set();

  @override
  State<StatefulWidget> createState() =>  _LevelListWidget(list, completedList);
}

class _LevelListWidget extends State<LevelListWidget> {

  List<LevelModel> levels;
  Set<LevelModel> completed;

  _LevelListWidget(this.levels, this.completed);

  Level _buildLevel(LevelModel model) => Level(
    level: model,
    onSolve: (solved) => setState(() {
      Navigator.of(context).pop();
      if (solved) {
        completed.add(model);
      } else {
        completed.remove(model);
      }
    }),
  );

  Widget _buildTile(LevelModel levelModel) {
    final isCompleteLevel = completed.contains(levelModel);
    return FlatButton(
      // todo: get colors from theme
      textColor: isCompleteLevel ? Colors.green : Colors.lightBlue,
      color: Theme.of(context).dialogBackgroundColor,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => _buildLevel(levelModel),
        ),
      ),  
      child: Text(levelModel.name),
    );
  }

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 4,

    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    padding: EdgeInsets.all(8),

    children: levels
      .map((level) => _buildTile(level))
      .toList(),
  );
}