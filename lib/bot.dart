// Interface
abstract class Bot {
  Move moveBy(Board b) {
    throw UnimplementedError(
        "Implement your own move by overriding thie method");
  }
}
