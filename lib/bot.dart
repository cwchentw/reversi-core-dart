/// The interface of our Reversi bot.
abstract class Bot {
  /// Implement this method in your own bot.
  Move moveBy(Board b) {
    throw UnimplementedError(
        "Implement your own move by overriding thie method");
  }
}
