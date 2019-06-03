import 'dart:math';

abstract class LevelModel {

  String name;
  String desc;

  num ask(num input);
  
  bool check(num input, num output) => ask(input) == output;

  num generate({ num min = 1, num max = 1000 * 1000 }) => Random().nextInt(max - min) + min;
}

class SimpleLevelModel extends LevelModel {

  final String name;
  final String desc;
  final Function solver;

  SimpleLevelModel(this.name, this.desc, this.solver);

  num ask(num input) => solver(input);
}