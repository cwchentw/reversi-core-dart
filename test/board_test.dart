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
}
