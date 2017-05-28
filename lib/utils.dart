import 'board.dart';

final pattern = new RegExp(r'^[a-h][1-8]$');

bool checkMove(string s) {
  if (s.contains(pattern)) {
    return true;
  }

  return false;
}

List<int> move2Loc(Move m) {
  var x = (m.index / 8).floor().toInt();
  var y = m.index % 8;

  var list = new List(2);
  list[0] = x;
  list[1] = y;
  return list;
}

Move str2Move(string s) {
  final ncol = s.substring(0, 1).codeUnitAt(0);
  final nrow = int.parse(s.substring(1, 2));

  // Calculate column by character code; 'a' is 97.
  return loc2Move(ncol - 97, nrow - 1);
}

Move loc2Move(int x, int y) {
  switch (x) {
    case 0:
      switch (y) {
        case 0:
          return Move.a1;
        case 1:
          return Move.a2;
        case 2:
          return Move.a3;
        case 3:
          return Move.a4;
        case 4:
          return Move.a5;
        case 5:
          return Move.a6;
        case 6:
          return Move.a7;
        case 7:
          return Move.a8;
      }
    case 1:
      switch (y) {
        case 0:
          return Move.b1;
        case 1:
          return Move.b2;
        case 2:
          return Move.b3;
        case 3:
          return Move.b4;
        case 4:
          return Move.b5;
        case 5:
          return Move.b6;
        case 6:
          return Move.b7;
        case 7:
          return Move.b8;
      }
    case 2:
      switch (y) {
        case 0:
          return Move.c1;
        case 1:
          return Move.c2;
        case 2:
          return Move.c3;
        case 3:
          return Move.c4;
        case 4:
          return Move.c5;
        case 5:
          return Move.c6;
        case 6:
          return Move.c7;
        case 7:
          return Move.c8;
      }
    case 3:
      switch (y) {
        case 0:
          return Move.d1;
        case 1:
          return Move.d2;
        case 2:
          return Move.d3;
        case 3:
          return Move.d4;
        case 4:
          return Move.d5;
        case 5:
          return Move.d6;
        case 6:
          return Move.d7;
        case 7:
          return Move.d8;
      }
    case 4:
      switch (y) {
        case 0:
          return Move.e1;
        case 1:
          return Move.e2;
        case 2:
          return Move.e3;
        case 3:
          return Move.e4;
        case 4:
          return Move.e5;
        case 5:
          return Move.e6;
        case 6:
          return Move.e7;
        case 7:
          return Move.e8;
      }
    case 5:
      switch (y) {
        case 0:
          return Move.f1;
        case 1:
          return Move.f2;
        case 2:
          return Move.f3;
        case 3:
          return Move.f4;
        case 4:
          return Move.f5;
        case 5:
          return Move.f6;
        case 6:
          return Move.f7;
        case 7:
          return Move.f8;
      }
    case 6:
      switch (y) {
        case 0:
          return Move.g1;
        case 1:
          return Move.g2;
        case 2:
          return Move.g3;
        case 3:
          return Move.g4;
        case 4:
          return Move.g5;
        case 5:
          return Move.g6;
        case 6:
          return Move.g7;
        case 7:
          return Move.g8;
      }
    case 7:
      switch (y) {
        case 0:
          return Move.h1;
        case 1:
          return Move.h2;
        case 2:
          return Move.h3;
        case 3:
          return Move.h4;
        case 4:
          return Move.h5;
        case 5:
          return Move.h6;
        case 6:
          return Move.h7;
        case 7:
          return Move.h8;
      }
  }

  throw 'Unknow move ' + x.toString() + ' ' + y.toString();
}
