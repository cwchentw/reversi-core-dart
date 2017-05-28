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
  reversi: "^0.1.0"
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