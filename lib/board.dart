import 'utils.dart';

const _SIZE = 8;

/// The discs in Reversi.
enum Disc { Black, White }

/// The game status.
enum Win { Black, White, Tie }

/// Available moves in Reversi.
///
/// In the following format:
///
///<pre>
///   |a |b |c |d |e |f |g |h |
/// 1 |  |  |  |  |  |  |  |  |1
/// 2 |  |  |  |  |  |  |  |  |2
/// 3 |  |  |  |  |  |  |  |  |3
/// 4 |  |  |  |W |B |  |  |  |4
/// 5 |  |  |  |B |W |  |  |  |5
/// 6 |  |  |  |  |  |  |  |  |6
/// 7 |  |  |  |  |  |  |  |  |7
/// 8 |  |  |  |  |  |  |  |  |8
///   |a |b |c |d |e |f |g |h |
///</pre>
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

/// Reversi Board.
///
/// The Reversi board can be either classical or reversed.
class Board {
  List<List<Disc>> _board;
  bool _isReversed;

  Board({reversed = false}) {
    _board = new List<List<Disc>>(_SIZE);
    _isReversed = reversed;

    for (var i = 0; i < _SIZE; i++) {
      _board[i] = new List<Disc>(_SIZE);
    }

    _setAt(Move.d5, Disc.Black);
    _setAt(Move.e4, Disc.Black);
    _setAt(Move.d4, Disc.White);
    _setAt(Move.e5, Disc.White);
  }

  /// Show the winner of the board.
  ///
  /// This method only show current winner. Therefore, only call it when the game is over.
  Win win() {
    var map = new Map();
    map[Disc.Black] = 0;
    map[Disc.White] = 0;

    for (var i = 0; i < _SIZE; i++) {
      for (var j = 0; j < _SIZE; j++) {
        var n = _board[i][j];
        switch (n) {
          case Disc.Black:
            map[Disc.Black]++;
            break;
          case Disc.White:
            map[Disc.White]++;
            break;
        }
      }
    }

    if (!_isReversed) {
      if (map[Disc.Black] > map[Disc.White]) {
        return Win.Black;
      } else if (map[Disc.Black] < map[Disc.White]) {
        return Win.White;
      } else {
        return Win.Tie;
      }
    } else {
      if (map[Disc.Black] < map[Disc.White]) {
        return Win.Black;
      } else if (map[Disc.Black] > map[Disc.White]) {
        return Win.White;
      } else {
        return Win.Tie;
      }
    }
  }

  /// Calculate the number of current black discs.
  int black() {
    var map = new Map();
    var count = 0;

    for (var i = 0; i < _SIZE; i++) {
      for (var j = 0; j < _SIZE; j++) {
        var n = _board[i][j];
        if (n == Disc.Black) {
          count++;
        }
      }
    }

    return count;
  }

  /// Calculate the number of current white discs.
  int white() {
    var map = new Map();
    var count = 0;

    for (var i = 0; i < _SIZE; i++) {
      for (var j = 0; j < _SIZE; j++) {
        var n = _board[i][j];
        if (n == Disc.White) {
          count++;
        }
      }
    }

    return count;
  }

  /// Get current disc at specific move.
  operator [](Move m) {
    final t = move2Loc(m);
    return _board[t[0]][t[1]];
  }

  /// Set a disc at specific move.
  ///
  /// Throw an exception string 'Not a valid move' when no valid move.
  operator []=(Move m, Disc disc) {
    bool isValid = false;
    bool isN = false;
    bool isS = false;
    bool isE = false;
    bool isW = false;
    bool isNE = false;
    bool isNW = false;
    bool isSE = false;
    bool isSW = false;

    if (_isNValid(m, disc)) {
      isN = true;
      isValid = true;
    }

    if (_isSValid(m, disc)) {
      isS = true;
      isValid = true;
    }

    if (_isEValid(m, disc)) {
      isE = true;
      isValid = true;
    }

    if (_isWValid(m, disc)) {
      isW = true;
      isValid = true;
    }

    if (_isNEValid(m, disc)) {
      isNE = true;
      isValid = true;
    }

    if (_isNWValid(m, disc)) {
      isNW = true;
      isValid = true;
    }

    if (_isSEValid(m, disc)) {
      isSE = true;
      isValid = true;
    }

    if (_isSWValid(m, disc)) {
      isSW = true;
      isValid = true;
    }

    if (!isValid) {
      throw 'Not a valid move';
    }

    if (isN) {
      _toggleN(m, disc);
    }

    if (isS) {
      _toggleS(m, disc);
    }

    if (isE) {
      _toggleE(m, disc);
    }

    if (isW) {
      _toggleW(m, disc);
    }

    if (isNE) {
      _toggleNE(m, disc);
    }

    if (isNW) {
      _toggleNW(m, disc);
    }

    if (isSE) {
      _toggleSE(m, disc);
    }

    if (isSW) {
      _toggleSW(m, disc);
    }
  }

  void _toggleN(Move m, Disc disc) {
    _setAt(m, disc);

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
    final y = t[1];

    for (var x = t[0] + 1; x < _SIZE; x++) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }
    }
  }

  void _toggleW(Move m, Disc disc) {
    _setAt(m, disc);

    final t = move2Loc(m);
    final y = t[1];

    for (var x = t[0] - 1; x >= 0; x--) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }
    }
  }

  void _toggleNE(Move m, Disc disc) {
    _setAt(m, disc);

    final t = move2Loc(m);
    var x = t[0] + 1;
    var y = t[1] - 1;

    while (x < _SIZE && y >= 0) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }

      x++;
      y--;
    }
  }

  void _toggleNW(Move m, Disc disc) {
    _setAt(m, disc);

    final t = move2Loc(m);
    var x = t[0] - 1;
    var y = t[1] - 1;

    while (x >= 0 && y >= 0) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }

      x--;
      y--;
    }
  }

  void _toggleSW(Move m, Disc disc) {
    _setAt(m, disc);

    final t = move2Loc(m);
    var x = t[0] - 1;
    var y = t[1] + 1;

    while (x >= 0 && y < _SIZE) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }

      x--;
      y++;
    }
  }

  void _toggleSE(Move m, Disc disc) {
    _setAt(m, disc);

    final t = move2Loc(m);
    var x = t[0] + 1;
    var y = t[1] + 1;

    while (x < _SIZE && y < _SIZE) {
      if (_board[x][y] != disc) {
        _board[x][y] = disc;
      } else {
        break;
      }

      x++;
      y++;
    }
  }

  void _setAt(Move m, Disc disc) {
    final t = move2Loc(m);
    _board[t[0]][t[1]] = disc;
  }

  /// Get valid moves for specific disc.
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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

    final t = move2Loc(m);
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
    final t = move2Loc(m);
    if (_board[t[0]][t[1]] == null) {
      return true;
    }
  }
}

/// Only for testing on some private methods.
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
  (() {
    Board b = new Board();
    b._toggleN(Move.e6, Disc.Black);

    _eq(b[Move.e5], Disc.Black);
    _eq(b[Move.e6], Disc.Black);
    _eq(b[Move.e4], Disc.Black);
    _eq(b[Move.e3], null);
    _eq(b[Move.d4], Disc.White);
  })();

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
  (() {
    Board b = new Board();
    b._toggleS(Move.d3, Disc.Black);

    _eq(b[Move.d3], Disc.Black);
    _eq(b[Move.d4], Disc.Black);
    _eq(b[Move.d5], Disc.Black);
    _eq(b[Move.d6], null);
    _eq(b[Move.e5], Disc.White);
  })();

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
  (() {
    Board b = new Board();
    b._toggleE(Move.c4, Disc.Black);

    _eq(b[Move.c4], Disc.Black);
    _eq(b[Move.d4], Disc.Black);
    _eq(b[Move.e4], Disc.Black);
    _eq(b[Move.f4], null);
    _eq(b[Move.e5], Disc.White);
  })();

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |o |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  (() {
    Board b = new Board();
    b._toggleW(Move.f5, Disc.Black);

    _eq(b[Move.d5], Disc.Black);
    _eq(b[Move.e5], Disc.Black);
    _eq(b[Move.f5], Disc.Black);
    _eq(b[Move.c5], null);
    _eq(b[Move.d4], Disc.White);
  })();

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |W |W |W |  |  |  |
  -------------------------
  |  |  |o |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  (() {
    Board b = new Board();

    b._setAt(Move.d5, Disc.White);
    b._setAt(Move.c5, Disc.White);

    b._toggleNE(Move.c6, Disc.Black);

    _eq(b[Move.c6], Disc.Black);
    _eq(b[Move.d5], Disc.Black);
    _eq(b[Move.e4], Disc.Black);

    _eq(b[Move.c5], Disc.White);
    _eq(b[Move.d4], Disc.White);
    _eq(b[Move.e5], Disc.White);

    _eq(b[Move.c4], null);
  })();

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |W |B |  |  |  |
  -------------------------
  |  |  |  |B |B |B |  |  |
  -------------------------
  |  |  |  |  |  |o |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  (() {
    Board b = new Board();

    b._setAt(Move.d5, Disc.Black);
    b._setAt(Move.f5, Disc.Black);

    b._toggleNW(Move.f6, Disc.White);

    _eq(b[Move.d4], Disc.White);
    _eq(b[Move.e5], Disc.White);
    _eq(b[Move.f6], Disc.White);

    _eq(b[Move.d5], Disc.Black);
    _eq(b[Move.e4], Disc.Black);
    _eq(b[Move.f5], Disc.Black);

    _eq(b[Move.f4], null);
  })();

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |o |  |  |
  -------------------------
  |  |  |  |W |W |W |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  (() {
    Board b = new Board();

    b._setAt(Move.e4, Disc.White);
    b._setAt(Move.f4, Disc.White);

    b._toggleSW(Move.f3, Disc.Black);

    _eq(b[Move.d5], Disc.Black);
    _eq(b[Move.e4], Disc.Black);
    _eq(b[Move.f3], Disc.Black);

    _eq(b[Move.d4], Disc.White);
    _eq(b[Move.e5], Disc.White);
    _eq(b[Move.f4], Disc.White);

    _eq(b[Move.f5], null);
  })();

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |o |  |  |  |  |  |
  -------------------------
  |  |  |B |B |B |  |  |  |
  -------------------------
  |  |  |  |B |W |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  (() {
    Board b = new Board();

    b._setAt(Move.c4, Disc.Black);
    b._setAt(Move.d4, Disc.Black);

    b._toggleSE(Move.c3, Disc.White);

    _eq(b[Move.c3], Disc.White);
    _eq(b[Move.d4], Disc.White);
    _eq(b[Move.e5], Disc.White);

    _eq(b[Move.c4], Disc.Black);
    _eq(b[Move.d5], Disc.Black);
    _eq(b[Move.e4], Disc.Black);

    _eq(b[Move.f6], null);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNValid(Move.d4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNValid(Move.d1, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.e6, Disc.White);
    _eq(b._isNValid(Move.e7, Disc.Black), true);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.d3, Disc.White);
    _eq(b._isNValid(Move.d6, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isSValid(Move.d4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isSValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isSValid(Move.b8, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.d3, Disc.White);
    _eq(b._isSValid(Move.d2, Disc.Black), true);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.e6, Disc.White);
    _eq(b._isSValid(Move.e3, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isEValid(Move.d4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isEValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isEValid(Move.h2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.c4, Disc.White);
    _eq(b._isEValid(Move.b4, Disc.Black), true);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.f5, Disc.White);
    _eq(b._isEValid(Move.c5, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isWValid(Move.d4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isWValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isWValid(Move.a3, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.f5, Disc.White);
    _eq(b._isWValid(Move.g5, Disc.Black), true);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.c4, Disc.White);
    _eq(b._isWValid(Move.g4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNEValid(Move.d4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNEValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNEValid(Move.h3, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.e3, Disc.Black);
    _eq(b._isNEValid(Move.c5, Disc.Black), true);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.c5, Disc.Black);
    _eq(b._isNEValid(Move.b6, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNWValid(Move.d4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNWValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isNWValid(Move.a3, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.f5, Disc.White);
    _eq(b._isNWValid(Move.g6, Disc.Black), true);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.c4, Disc.White);
    _eq(b._isNWValid(Move.e6, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isSWValid(Move.d4, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isSWValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isSWValid(Move.c8, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();

    b._setAt(Move.d5, Disc.White);
    b._setAt(Move.d6, Disc.White);
    b._setAt(Move.c7, Disc.Black);

    _eq(b._isSWValid(Move.f4, Disc.Black), true);
  })();

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
  (() {
    Board b = new Board();

    b._setAt(Move.d5, Disc.White);
    b._setAt(Move.d6, Disc.White);

    _eq(b._isSWValid(Move.f4, Disc.Black), false);
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
  (() {
    Board b = new Board();
    _eq(b._isSEValid(Move.d4, Disc.Black), false);
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
  (() {
    Board b = new Board();
    _eq(b._isSEValid(Move.b2, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    _eq(b._isSEValid(Move.c8, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.f6, Disc.Black);
    _eq(b._isSEValid(Move.c8, Disc.Black), false);
  })();

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
  (() {
    Board b = new Board();
    b._setAt(Move.c3, Disc.Black);
    _eq(b._isSEValid(Move.b2, Disc.Black), false);
  })();
}

bool _eq(a, b) {
  if (!(a == b)) {
    throw a.toString() + ' and ' + b.toString() + ' are not equal';
  }
  ;
}
