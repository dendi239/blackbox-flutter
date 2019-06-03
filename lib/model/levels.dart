import 'level.dart';

class Levels {

  static final levels = [
    SimpleLevelModel(
      name: '1',
      desc: 'Think of basic math operations',
      solver: (n) => n + 1,
    ),
    SimpleLevelModel(
      name: '2',
      desc: 'Think of basic math operations',
      solver: (n) => n * 2,
    ),
    SimpleLevelModel(
      name: '3',
      desc: 'Think of basic math operations',
      solver: (n) => n ~/ 3 + 1,
    ),
    SimpleLevelModel(
      name: '4',
      desc: 'Think of the result of division',
      solver: (n) => n % 7,
    ),
    DigitsBasedLevelModel(
      name: '5',
      desc: 'Think of the digits',
      solver: (s) => s.length,
    ),
    DigitsBasedLevelModel(
      name: '6',
      desc: 'Think of the digits order',
      solver: (s) => s.reversed,
    ),
    DigitsBasedLevelModel(
      name: '7',
      desc: 'Think of the digits',
      solver: (ds) => [ds.reduce((a, b) => a + b)],
    ),
    SimpleLevelModel(
      name: '8',
      desc: 'Think of the number parity',
      solver: (n) {
        if (n % 2 == 0)
          return n + 5;
        else
          return n + 10;
      },
    ),
    SimpleLevelModel(
      name: '9',
      desc: 'Think of square polynomial',
      solver: (n) => n * n + n + 1,
    ),
    DigitsBasedLevelModel(
      name: '10',
      desc: '',
      solver: (ds) => ds..sort(),
    ),
    SimpleLevelModel(
      name: '42',
      desc: 'Think of life',
      solver: (n) => 42,
    )    
  ];
  
}