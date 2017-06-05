import 'dart:io';
import 'package:reversi/reversi.dart';

void main() {
  bool isReversed;
  while (isReversed == null) {
    stdout.write("Please choose game type (C/c) Classical, (R/r) Reversed: ");
    String input = stdin.readLineSync();
    if (input == "C" || input == "c") {
      isReversed = false;
    } else if (input == "R" || input == "r") {
      isReversed = true;
    } else {
      stderr.writeln("Invalid game type");
    }
  }

  Disc side;
  while (side == null) {
    stdout.write("Please choose your side (B/b) Black, (W/w) White: ");
    String input = stdin.readLineSync();
    if (input == "b" || input == "B") {
      side = Disc.Black;
    } else if (input == "w" || input == "W") {
      side = Disc.White;
    } else {
      stderr.writeln("Invalid side");
    }
  }

  Board b = new Board(reversed: isReversed);
  if (side == Disc.Black) {
    Bot bot = new EasyBot(Disc.White, reversed: isReversed);

    while (true) {
      drawBoard(b);
      var isBlackMoved = false;
      var isWhiteMoved = false;

      var mb;
      var mbs = b.validMoves(Disc.Black);
      if (!mbs.isEmpty) {
        while (mb == null) {
          stdout.write('Please move your disc (a1-h8): ');
          String p = stdin.readLineSync();
          if (checkMove(p)) {
            var mb = str2Move(p);
            var s = new Set.from(mbs);

            if (s.contains(mb)) {
              b[mb] = Disc.Black;
            } else {
              stderr.writeln('Wrong move');
              continue;
            }

            break;
          } else {
            stderr.writeln('Invalid move');
          }
        }

        isBlackMoved = true;
      } else {
        stderr.writeln('No avaiable Black move');
      }

      var mws = b.validMoves(Disc.White);
      if (!mws.isEmpty) {
        var mw = bot.moveBy(b);
        b[mw] = Disc.White;
        isWhiteMoved = true;
      } else {
        stderr.writeln('No avaliable White move');
      }

      if (!isBlackMoved && !isWhiteMoved) {
        break;
      }
    }
  } else if (side == Disc.White) {
    Bot bot = new EasyBot(Disc.Black, reversed: isReversed);

    while (true) {
      var isBlackMoved = false;
      var isWhiteMoved = false;

      var mbs = b.validMoves(Disc.Black);
      if (!mbs.isEmpty) {
        var mb = bot.moveBy(b);
        b[mb] = Disc.Black;
        isBlackMoved = true;
      } else {
        stderr.writeln('No avaliable Black move');
      }

      drawBoard(b);

      var mw;
      var mws = b.validMoves(Disc.White);
      if (!mws.isEmpty) {
        while (mw == null) {
          stdout.write('Please move your disc (a1-h8): ');
          String p = stdin.readLineSync();
          if (checkMove(p)) {
            var mw = str2Move(p);
            var s = new Set.from(mws);

            if (s.contains(mw)) {
              b[mw] = Disc.White;
            } else {
              stderr.writeln('Wrong move');
              continue;
            }

            break;
          } else {
            stderr.writeln('Invalid move');
          }
        }

        isWhiteMoved = true;
      } else {
        stderr.writeln('No avaiable White move');
      }

      if (!isBlackMoved && !isWhiteMoved) {
        break;
      }
    }
  } else {
    stderr.writeln('Invalid side');
    exit(1);
  }

  drawBoard(b);
  stdout.writeln('Black: ' + b.black().toString());
  stdout.writeln('White: ' + b.white().toString());

  final w = b.win();
  if (w == Win.Black) {
    stdout.writeln('Black player win');
  } else if (w == Win.White) {
    stdout.writeln('White player win');
  } else {
    stdout.writeln('Tie');
  }
}

void drawBoard(Board b) {
  stdout.writeln('  |a |b |c |d |e |f |g |h |  ');
  for (var i = 0; i < 8; i++) {
    stdout.write((i + 1).toString() + ' ');
    for (var j = 0; j < 8; j++) {
      var m = loc2Move(j, i);
      var d = b[m];

      if (d == Disc.Black) {
        stdout.write('|B ');
      } else if (d == Disc.White) {
        stdout.write('|W ');
      } else {
        stdout.write('|  ');
      }
    }
    stdout.writeln('|' + (i + 1).toString() + ' ');
  }
  stdout.writeln('  |a |b |c |d |e |f |g |h |  ');
}
