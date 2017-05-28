import 'dart:math';
import 'package:algo/algo.dart';

import 'board.dart';
import 'utils.dart';

// Interface
abstract class Bot {
  Move moveBy(Board b) {
    throw UnimplementedError(
        "Implement your own move by overriding thie method");
  }
}

class EasyBot implements Bot {
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
