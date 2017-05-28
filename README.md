# Reversi in Dart

This repo implements the core algorithm for Reversi. No UI part.

## Install

Install the console program:

```
pub global activate reversi
```

You may install the package locally:

```
dependencies:
  reversi: "^0.1.1"
```

## Usage

Play our console program:

```
$ reversi
Please choose your side (B/b) Black, (W/w) White: b
  |a |b |c |d |e |f |g |h |  
1 |  |  |  |  |  |  |  |  |1 
2 |  |  |  |  |  |  |  |  |2 
3 |  |  |  |  |  |  |  |  |3 
4 |  |  |  |W |B |  |  |  |4 
5 |  |  |  |B |W |  |  |  |5 
6 |  |  |  |  |  |  |  |  |6 
7 |  |  |  |  |  |  |  |  |7 
8 |  |  |  |  |  |  |  |  |8 
  |a |b |c |d |e |f |g |h |  
Please move your disc (a1-h8): c4
  |a |b |c |d |e |f |g |h |  
1 |  |  |  |  |  |  |  |  |1 
2 |  |  |  |  |  |  |  |  |2 
3 |  |  |W |  |  |  |  |  |3 
4 |  |  |B |W |B |  |  |  |4 
5 |  |  |  |B |W |  |  |  |5 
6 |  |  |  |  |  |  |  |  |6 
7 |  |  |  |  |  |  |  |  |7 
8 |  |  |  |  |  |  |  |  |8 
  |a |b |c |d |e |f |g |h |  
Please move your disc (a1-h8): ...
```

## Intro

Dart is a cross-platform programming language capable of web frontend, web backend, mobile, and console applications. The package implemented the core business logic for Reversi. You may utilize this package for diverse applications.

A sample code:

```
Board b = new Board();
Bot bot = new EasyBot(Disc.White);

// The game loop.
while (true) {
  // You have to implement your own drawBoard function.
  drawBoard(b);
  var isBlackMoved = false;
  var isWhiteMoved = false;

  // The round of black player, who is a man.
  var mbs = b.validMoves(Disc.Black);
  if (!mbs.isEmpty) {
    var mb;
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

  // The round of white player, which is bot.
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

// Show the final result.
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
```

We shipped a console Reversi program for demo purpose. Currently, there is only one level of bot. See the source of our console program for more details. More bots and applicaions are on the way.

You may implement your own Reversi bot. You only need to fulfill this interface:

```
// Interface
abstract class Bot {
  Move moveBy(Board b) {
    // No implementation.
  }
}

// Implement your own bot.
class MyBot implements Bot {
  // Some fields and methods.

  @override
  Move moveBy(Board b) {
    // Implement it here.
  }
}
```

## Copyright

2017, Michael Chen

## License

MIT