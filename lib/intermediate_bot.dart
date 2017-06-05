import 'dart:math';
import 'package:algo/algo.dart';

import 'bot.dart';
import 'board.dart';
import 'utils.dart';

/// A Factory Class for IntermediateBot.
///
/// You may select either classical or reversed bot.
class IntermediateBot implements Bot {
  factory IntermediateBot(Disc disc, {reversed = false}) {
    if (reversed == false) {
      return new IntermediateClassicalBot(disc);
    } else {
      return new IntermediateReversedBot(disc);
    }
  }
}

/// A intermediate level abstract Reversi bot.
///
/// This abstract class is only for shared algorithm of easy bots.
abstract class AbstractIntermediateBot implements Bot {
  static Matrix _weights = new Matrix.fromMatrix([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0]
  ]);

  Disc _disc;

  IntermediateBot(Disc disc) {
    _disc = disc;
  }

  @override
  Move moveBy(Board b) {
    // Implement it later.
  }
}

class IntermediateClassicalBot extends AbstractIntermediateBot implements Bot {
  // Implement it later.
}

class IntermediateReversedBot extends AbstractIntermediateBot implements Bot {
  // Implement it later.
}
