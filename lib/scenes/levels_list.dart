import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:blackbox/model/level.dart';
import 'package:blackbox/model/levels.dart';
import 'level/level.dart';

class LevelListWidget extends StatefulWidget {

  // todo: get (or inject) levels somehow
  final List<LevelModel> list = Levels.levels;
  final Set<LevelModel> completedLevels = Set();

  LevelListWidget();

  @override
  State<StatefulWidget> createState() =>  _LevelListWidget(list, completedLevels);
}

class _LevelListWidget extends State<LevelListWidget> {

  List<LevelModel> levels;
  Set<LevelModel> completed;

  _LevelListWidget(this.levels, this.completed) {
    _load();
  }

  _load() async {
    final preferences = await SharedPreferences.getInstance();
    final completedList = preferences.getStringList("completed");

    if (completedList == null) {
      return;
    }

    setState(() {
      completed = levels
        .where((level) => completedList.contains(level.name))
        .toSet();
    });
  }

  Level _buildLevel(LevelModel model) => Level(
    level: model,
    onSolve: (solved) => setState(() async {
      Navigator.of(context).pop();

      if (solved) {
        completed.add(model);
      } else {
        completed.remove(model);
      }

      final preferences = await SharedPreferences.getInstance();
      await preferences.setStringList(
        "completed",
        completed
          .map((level) => level.name)
          .toList(),
      );
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