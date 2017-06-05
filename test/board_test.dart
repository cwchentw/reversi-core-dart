import "package:test/test.dart";
import 'dart:mirrors';

import "package:reversi/reversi.dart";

void main() {
  test("Board getter", () {
    Board b = new Board();
    expect(b[Move.a1], null);
    expect(b[Move.d5], Disc.Black);
    expect(b[Move.d4], Disc.White);
  });

  test('Board hashCode', () {
    Board b1 = new Board();
    Board b2 = new Board();

    expect(b1, b2);

    var map = new Map();
    map[b1] = 3;
    expect(map[b2], 3);
  });

  test('Board clone', () {
    Board b1 = new Board();
    Board b2 = b1.clone;

    expect(b1, b2);

    b2[Move.c4] = Disc.Black;

    expect(b1 == b2, false);
  });

  /*
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |o |  |  |  |  |
  -------------------------
  |  |  |o |W |B |  |  |  |
  -------------------------
  |  |  |  |B |W |o |  |  |
  -------------------------
  |  |  |  |  |o |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("Board valid moves", () {
    Board b = new Board();
    var m = b.validMoves(Disc.Black);

    expect(new Set.from(m), new Set.from([Move.c4, Move.d3, Move.e6, Move.f5]));
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
  |  |  |  |  |o |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  -------------------------
  |  |  |  |  |  |  |  |  |
  */
  test("Board move", () {
    Board b = new Board();
    b[Move.e6] = Disc.Black;

    expect(b[Move.e3], null);
    expect(b[Move.e4], Disc.Black);
    expect(b[Move.e5], Disc.Black);
    expect(b[Move.e6], Disc.Black);

    expect(b[Move.d4], Disc.White);
  });

  test("Board winner", () {
    Board b = new Board();
    expect(b.win(), Win.Tie);

    b[Move.e6] = Disc.Black;
    expect(b.win(), Win.Black);
  });
}
