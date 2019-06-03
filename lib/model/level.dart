import 'dart:math';

abstract class LevelModel {

  String name;
  String desc;

  num ask(num input);
  
  bool check(num input, num output) => ask(input) == output;

  num generate({ num min = 1, num max = 100 }) => Random().nextInt(max - min) + min;
}

class SimpleLevelModel extends LevelModel {

  final String name;
  final String desc;
  final Function solver;

  SimpleLevelModel({ this.name, this.desc, this.solver });

  num ask(num input) => solver(input);
}

class DigitsBasedLevelModel extends LevelModel {
  
  final String name;
  final String desc;
  final Function(List<int>) solver;

  DigitsBasedLevelModel({ this.name, this.desc, this.solver });

  num ask(num input) {
    final digits = input.toString()
      .split('')
      .map((d) => int.parse(d))
      .toList();
    final resultString = solver(digits)
      .map((d) => d.toString())
      .join('');
    return num.parse(resultString);
  }
}