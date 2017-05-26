const _SIZE = 8;
enum Disc { White, Black }
enum Move {
  a1,
  a2,
  a3,
  a4,
  a5,
  a6,
  a7,
  a8,
  b1,
  b2,
  b3,
  b4,
  b5,
  b6,
  b7,
  b8,
  c1,
  c2,
  c3,
  c4,
  c5,
  c6,
  c7,
  c8,
  d1,
  d2,
  d3,
  d4,
  d5,
  d6,
  d7,
  d8,
  e1,
  e2,
  e3,
  e4,
  e5,
  e6,
  e7,
  e8,
  f1,
  f2,
  f3,
  f4,
  f5,
  f6,
  f7,
  f8,
  g1,
  g2,
  g3,
  g4,
  g5,
  g6,
  g7,
  g8,
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  h7,
  h8
}

class Board {
  List<List<Disc>> _board;

  Board() {
    _board = new List<List<Disc>>(_SIZE);

    for (var i = 0; i < _SIZE; i++) {
      _board[i] = new List<Disc>(_SIZE);
    }

    this[Move.d5] = Disc.Black;
    this[Move.e4] = Disc.Black;
    this[Move.d4] = Disc.White;
    this[Move.e5] = Disc.White;
  }

  operator [](Move m) {
    final t = _move2Loc(m);
    return _board[t[0]][t[1]];
  }

  operator []=(Move m, Disc disc) {
    final t = _move2Loc(m);
    _board[t[0]][t[1]] = disc;
  }

  bool isValid(Move m, Disc disc) {
    if (isNValid(m, disc) == true) {
      return true;
    }

    return false;
  }

  bool isNValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    final x = t[0];
    if (t[1] - 1 < 0) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    for (var y = t[1] - 1; y >= 0; y--) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        continue;
      }

      if (!isOther && _board[x][y] == disc) {
        break;
      }

      if (isOther && _board[x][y] == disc) {
        isSelf = true;
        break;
      }
    }

    if (isOther && isSelf) {
      return true;
    }

    return false;
  }

  bool isSValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    final x = t[0];
    if (t[1] + 1 >= _SIZE) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    for (var y = t[1] + 1; y < _SIZE; y++) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        continue;
      }

      if (!isOther && _board[x][y] == disc) {
        break;
      }

      if (isOther && _board[x][y] == disc) {
        isSelf = true;
        break;
      }
    }

    if (isOther && isSelf) {
      return true;
    }

    return false;
  }

  bool isEValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    final y = t[1];
    if (t[0] + 1 >= _SIZE) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    for (var x = t[0] + 1; x < _SIZE; x++) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        continue;
      }

      if (!isOther && _board[x][y] == disc) {
        break;
      }

      if (isOther && _board[x][y] == disc) {
        isSelf = true;
        break;
      }
    }

    if (isOther && isSelf) {
      return true;
    }

    return false;
  }

  bool isWValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    final y = t[1];
    if (t[0] - 1 < 0) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    for (var x = t[0] - 1; x >= 0; x--) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        continue;
      }

      if (!isOther && _board[x][y] == disc) {
        break;
      }

      if (isOther && _board[x][y] == disc) {
        isSelf = true;
        break;
      }
    }

    if (isOther && isSelf) {
      return true;
    }

    return false;
  }

  bool isNEValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    if (t[0] + 1 >= _SIZE) {
      return false;
    }

    if (t[1] - 1 < 0) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    var x = t[0] + 1;
    var y = t[1] - 1;
    while (x < _SIZE && y >= 0) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        x++;
        y--;
        continue;
      }

      if (!isOther && _board[x][y] == disc) {
        break;
      }

      if (isOther && _board[x][y] == disc) {
        isSelf = true;
        break;
      }

      x++;
      y--;
    }

    if (isOther && isSelf) {
      return true;
    }

    return false;
  }

  bool isNWValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    if (t[0] - 1 < 0) {
      return false;
    }

    if (t[1] - 1 < 0) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    var x = t[0] - 1;
    var y = t[1] - 1;
    while (x >= 0 && y >= 0) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        x--;
        y--;
        continue;
      }

      if (!isOther && _board[x][y] == disc) {
        break;
      }

      if (isOther && _board[x][y] == disc) {
        isSelf = true;
        break;
      }

      x--;
      y--;
    }

    if (isOther && isSelf) {
      return true;
    }

    return false;
  }

  bool _isEmpty(Move m) {
    final t = _move2Loc(m);
    if (_board[t[0]][t[1]] == null) {
      return true;
    }
  }
}

List<int> _move2Loc(Move m) {
  var x = (m.index / 8).floor().toInt();
  var y = m.index % 8;
  return _getLoc(x, y);
}

List<int> _getLoc(int x, int y) {
  var list = new List(2);
  list[0] = x;
  list[1] = y;
  return list;
}

Move _loc2Move(int x, int y) {
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
