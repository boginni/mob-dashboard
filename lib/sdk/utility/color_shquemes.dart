import 'dart:ui';

class ColorPallet {
  static int i = 0;

  static Color getColor() {
    try {
      return colors[i++];
    } catch (e) {
      i = 0;
      return colors[i++];
    }
  }

  static const colors = [
    Color(0xAA2B70A7),
    Color(0xAABF1E2E),
    Color(0xAAEF4136),
    Color(0xAAF15A2B),
    Color(0xAAE2B37D),
    Color(0xAA2A3890),
    Color(0xAA28AAE1),
    Color(0xAA77B3E1),
    Color(0xAAB5D4EF),
    Color(0xAA006838),
    Color(0xAA009445),
    Color(0xAA39B54A),
    Color(0xAA8DC73F),
    Color(0xAAD7E022),
    Color(0xAAF9ED32),
    Color(0xAAF5F194),
    Color(0xAAF2F5CD),
    Color(0xAA7B5231),
    Color(0xAA68499E),
    Color(0xAA662D91),
    Color(0xAAF20B97),
    Color(0xAAF453AD),
    Color(0xAAEE73C4),
    Color(0xAAF29EC8),
    Color(0xAAF9BBE6),
  ];
}
