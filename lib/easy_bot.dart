import 'dart:math';
import 'package:algo/algo.dart';

import 'bot.dart';
import 'board.dart';
import 'utils.dart';

/// A Factory Class for EasyBot.
///
/// You may select either classical or reversed bot.
class EasyBot implements Bot {
  factory EasyBot(Disc disc, {reversed = false}) {
    if (reversed == false) {
      return new EasyClassicalBot(disc);
    } else {
      return new EasyReversedBot(disc);
    }
  }
}

/// A easy level abstract Reversi bot.
///
/// This abstract class is only for shared algorithm of easy bots.
abstract class AbstractEasyBot implements Bot {
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

  EasyBot(Disc disc) {
    _disc = disc;
  }

  @override
  Move moveBy(Board b) {
    List<Move> moves = b.validMoves(_disc);
    Map<Move, int> map = new Map();

    var max = -9999;
    for (var m in moves) {
      final t = move2Loc(m);
      final x = t[0];
      final y = t[1];
      final w = _weights[[x, y]];

      if (w > max) {
        max = w;
      }

      map[m] = w;
    }

    List<Move> list = [];
    for (var k in map.keys) {
      if (map[k] >= max) {
        list.add(k);
      }
    }

    if (list.length <= 0) {
      throw 'No valid move';
    } else if (list.length == 1) {
      return list[0];
    } else {
      var listNew = _shuffle(list);
      return listNew[0];
    }
  }
}

/// A easy level classical Reversi bot.
///
/// We use only one level weight table for its AI, intending for beginners.
class EasyClassicalBot extends AbstractEasyBot implements Bot {
  static Matrix _weights = new Matrix.fromMatrix([
    [99, -8, 8, 6, 6, 8, -8, 99],
    [-8, -24, -4, -3, -3, -4, -24, -8],
    [8, -4, 7, 4, 4, 7, -4, 8],
    [6, -3, 4, 0, 0, 4, -3, 6],
    [6, -3, 4, 0, 0, 4, -3, 6],
    [8, -4, 7, 4, 4, 7, -4, 8],
    [-8, -24, -4, -3, -3, -4, -24, -8],
    [99, -8, 8, 6, 6, 8, -8, 99]
  ]);

  EasyClassicalBot(Disc disc) {
    super.EasyBot(disc);
  }
}

/// A easy level reversed Reversi bot.
///
/// We use only one level weight table for its AI, intending for beginners.
class EasyReversedBot extends AbstractEasyBot implements Bot {
  // Update weight matrix for reversed Reversi.
  static Matrix _weights = new Matrix.fromMatrix([
    [-99, 48, -8, 6, 6, -8, 48, -99],
    [48, -8, -16, 3, 3, -16, -8, 48],
    [-8, -16, 4, 4, 4, 4, -16, -8],
    [6, 3, 4, 0, 0, 4, 3, 6],
    [6, 3, 4, 0, 0, 4, 3, 6],
    [-8, -16, 4, 4, 4, 4, -16, -8],
    [48, -8, -16, 3, 3, -16, -8, 48],
    [-99, 48, -8, 6, 6, -8, 48, -99]
  ]);

  EasyReversedBot(Disc disc) {
    super.EasyBot(disc);
  }
}

List _shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
