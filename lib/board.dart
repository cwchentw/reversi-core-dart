import "package:test/test.dart";

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

    _setAt(Move.d5, Disc.Black);
    _setAt(Move.e4, Disc.Black);
    _setAt(Move.d4, Disc.White);
    _setAt(Move.e5, Disc.White);
  }

  operator [](Move m) {
    final t = _move2Loc(m);
    return _board[t[0]][t[1]];
  }

  operator []=(Move m, Disc disc) {
    if (!isValid(m, disc)) {
      throw 'Invalid move';
    }
    _setAt(m, disc);
  }

  void _setAt(Move m, Disc disc) {
    final t = _move2Loc(m);
    _board[t[0]][t[1]] = disc;
  }

  void _toggleN(Move m, Disc disc) {
    _setAt(m, disc);
    
    final t = _move2Loc(m);
    final x = t[0];

    for (var y = t[1] - 1; y >= 0; y--) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }
    }
  }
  
  void _toggleS(Move m, Disc disc) {
    _setAt(m, disc);
    
    final t = _move2Loc(m);
    final x = t[0];

    for (var y = t[1] + 1; y < _SIZE; y++) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }
    }
  }

  void _toggleE(Move m, Disc disc) {
    _setAt(m, disc);
    
    final t = _move2Loc(m);
    final y = t[1];

    for (var x = t[0] + 1; x < _SIZE; x++) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }
    }
  }

  List<Disc> validMoves(Disc disc) {
    List<Disc> moves = [];

    for (var m in Move.values) {
      if (_isValid(m, disc)) {
        moves.add(m);
      }
    }

    return moves;
  }

  bool _isValid(Move m, Disc disc) {
    if (_isNValid(m, disc) == true ||
        _isSValid(m, disc) == true ||
        _isEValid(m, disc) == true ||
        _isWValid(m, disc) == true ||
        _isNEValid(m, disc) == true ||
        _isNWValid(m, disc) == true ||
        _isSEValid(m, disc) == true ||
        _isSWValid(m, disc) == true) {
      return true;
    }

    return false;
  }

  bool _isNValid(Move m, Disc disc) {
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

  bool _isSValid(Move m, Disc disc) {
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

  bool _isEValid(Move m, Disc disc) {
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

  bool _isWValid(Move m, Disc disc) {
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

  bool _isNEValid(Move m, Disc disc) {
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

  bool _isNWValid(Move m, Disc disc) {
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

  bool _isSWValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    if (t[0] - 1 < 0) {
      return false;
    }

    if (t[1] + 1 >= _SIZE) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    var x = t[0] - 1;
    var y = t[1] + 1;
    while (x >= 0 && y < _SIZE) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        x--;
        y++;
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
      y++;
    }

    if (isOther && isSelf) {
      return true;
    }

    return false;
  }

  bool _isSEValid(Move m, Disc disc) {
    if (_isEmpty(m) != true) {
      return false;
    }

    final t = _move2Loc(m);
    if (t[0] + 1 >= _SIZE) {
      return false;
    }

    if (t[1] + 1 >= _SIZE) {
      return false;
    }

    var isSelf = false;
    var isOther = false;
    var x = t[0] + 1;
    var y = t[1] + 1;
    while (x < _SIZE && y < _SIZE) {
      if (_board[x][y] == null) {
        break;
      }

      if (_board[x][y] != disc) {
        isOther = true;
        x++;
        y++;
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
      y++;
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

// Unit tests for private methods
void main() {
  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |o |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_toggleN", () {
    Board b = new Board();
    b._toggleN(Move.e6, Disc.Black);
    
    expect(b[Move.e5], Disc.Black);
    expect(b[Move.e6], Disc.Black);
    expect(b[Move.e4], Disc.Black);
    expect(b[Move.e3], null);
    expect(b[Move.d4], Disc.White);
  });
  
  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |o |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_toggleS", () {
    Board b = new Board();
    b._toggleS(Move.d3, Disc.Black);
    
    expect(b[Move.d3], Disc.Black);
    expect(b[Move.d4], Disc.Black);
    expect(b[Move.d5], Disc.Black);
    expect(b[Move.d6], null);
    expect(b[Move.e5], Disc.White);
  });
  
  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |o |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_toggleE", () {
    Board b = new Board();
    b._toggleE(Move.c4, Disc.Black);
    
    expect(b[Move.c4], Disc.Black);
    expect(b[Move.d4], Disc.Black);
    expect(b[Move.e4], Disc.Black);
    expect(b[Move.f4], null);
    expect(b[Move.e5], Disc.White);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNValid occupied", () {
    Board b = new Board();
    expect(b._isNValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNValid empty", () {
    Board b = new Board();
    expect(b._isNValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |o |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNValid side", () {
    Board b = new Board();
    expect(b._isNValid(Move.d1, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |W |  |  |  |
  -------------------------
  |  |  |  |  |o |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNValid valid", () {
    Board b = new Board();
    b._setAt(Move.e6, Disc.White);
    expect(b._isNValid(Move.e7, Disc.Black), true);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |o |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNValid invalid", () {
    Board b = new Board();
    b._setAt(Move.d3, Disc.White);
    expect(b._isNValid(Move.d6, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSValid occupied", () {
    Board b = new Board();
    expect(b._isSValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSValid empty", () {
    Board b = new Board();
    expect(b._isSValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  */
  test("_isSValid side", () {
    Board b = new Board();
    expect(b._isSValid(Move.b8, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |o |  |  |  |  |
  -------------------------
  |  |  |  |W |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  */
  test("_isSValid valid", () {
    Board b = new Board();
    b._setAt(Move.d3, Disc.White);
    expect(b._isSValid(Move.d2, Disc.Black), true);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |o |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  */
  test("_isSValid invalid", () {
    Board b = new Board();
    b._setAt(Move.e6, Disc.White);
    expect(b._isSValid(Move.e3, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isEValid occupied", () {
    Board b = new Board();
    expect(b._isEValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isEValid empty", () {
    Board b = new Board();
    expect(b._isEValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |o |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isEValid side", () {
    Board b = new Board();
    expect(b._isEValid(Move.h2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |W |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isEValid valid", () {
    Board b = new Board();
    b._setAt(Move.c4, Disc.White);
    expect(b._isEValid(Move.b4, Disc.Black), true);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |o |B |W |W |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isEValid invalid", () {
    Board b = new Board();
    b._setAt(Move.f5, Disc.White);
    expect(b._isEValid(Move.c5, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isWValid occupied", () {
    Board b = new Board();
    expect(b._isWValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isWValid empty", () {
    Board b = new Board();
    expect(b._isWValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |o |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isWValid side", () {
    Board b = new Board();
    expect(b._isWValid(Move.a3, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |W |o |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isWValid valid", () {
    Board b = new Board();
    b._setAt(Move.f5, Disc.White);
    expect(b._isWValid(Move.g5, Disc.Black), true);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |W |W |B |o |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isWValid invalid", () {
    Board b = new Board();
    b._setAt(Move.c4, Disc.White);
    expect(b._isWValid(Move.g4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNEValid occupied", () {
    Board b = new Board();
    expect(b._isNEValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNEValid empty", () {
    Board b = new Board();
    expect(b._isNEValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |o |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNEValid side", () {
    Board b = new Board();
    expect(b._isNEValid(Move.h3, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |B |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |o |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNEValid valid", () {
    Board b = new Board();
    b._setAt(Move.e3, Disc.Black);
    expect(b._isNEValid(Move.c5, Disc.Black), true);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |B |B |W |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNEValid invalid", () {
    Board b = new Board();
    b._setAt(Move.c5, Disc.Black);
    expect(b._isNEValid(Move.b6, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNWValid occupied", () {
    Board b = new Board();
    expect(b._isNWValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNWValid empty", () {
    Board b = new Board();
    expect(b._isNWValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |o |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNWValid side", () {
    Board b = new Board();
    expect(b._isNWValid(Move.a3, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |W |  |  |
  -------------------------
  |  |  |  |  |  |  |o |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNWValid valid", () {
    Board b = new Board();
    b._setAt(Move.f5, Disc.White);
    expect(b._isNWValid(Move.g6, Disc.Black), true);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |W |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |o |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isNWValid invalid", () {
    Board b = new Board();
    b._setAt(Move.c4, Disc.White);
    expect(b._isNWValid(Move.e6, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSWValid occupied", () {
    Board b = new Board();
    expect(b._isSWValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSWValid empty", () {
    Board b = new Board();
    expect(b._isSWValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |o |  |  |  |  |  |
  */
  test("_isSWValid side", () {
    Board b = new Board();
    expect(b._isSWValid(Move.c8, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |o |  |  |
  -------------------------
  |  |  |  |W |W |  |  |  |
  -------------------------
  |  |  |  |W |  |  |  |  |
  -------------------------
  |  |  |B |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSWValid valid", () {
    Board b = new Board();

    b._setAt(Move.d5, Disc.White);
    b._setAt(Move.d6, Disc.White);
    b._setAt(Move.c7, Disc.Black);

    expect(b._isSWValid(Move.f4, Disc.Black), true);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |o |  |  |
  -------------------------
  |  |  |  |W |W |  |  |  |
  -------------------------
  |  |  |  |W |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSWValid invalid", () {
    Board b = new Board();

    b._setAt(Move.d5, Disc.White);
    b._setAt(Move.d6, Disc.White);

    expect(b._isSWValid(Move.f4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |Wo|B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSEValid occupied", () {
    Board b = new Board();
    expect(b._isSEValid(Move.d4, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSEValid empty", () {
    Board b = new Board();
    expect(b._isSEValid(Move.b2, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |o |  |  |  |  |  |
  */
  test("_isSEValid side", () {
    Board b = new Board();
    expect(b._isSEValid(Move.c8, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |o |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |B |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSEValid valid", () {
    Board b = new Board();
    b._setAt(Move.f6, Disc.Black);
    expect(b._isSEValid(Move.c8, Disc.Black), false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |o |  |  |  |  |  |  |
  -------------------------
  |  |  |B |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("_isSEValid valid", () {
    Board b = new Board();
    b._setAt(Move.c3, Disc.Black);
    expect(b._isSEValid(Move.b2, Disc.Black), false);
  });
}
