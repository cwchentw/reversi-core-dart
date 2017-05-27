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
  test("Board isValid", () {
    Board b = new Board();
    expect(b.isValid(Move.c4, Disc.Black), true);
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
  test("Board isValid", () {
    Board b = new Board();
    var m = b.moves(Disc.Black);

    expect(new Set.from(m), new Set.from([Move.c4, Move.d3, Move.e6, Move.f5]));
  });
}
