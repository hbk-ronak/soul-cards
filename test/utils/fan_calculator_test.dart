import 'package:flutter_test/flutter_test.dart';
import 'package:soul_cards/utils/fan_calculator.dart';

void main() {
  group('FanCalculator', () {
    test('should calculate positions for iPhone viewport', () {
      final calculator = FanCalculator(
        screenWidth: 393.0, // iPhone 14/15 Pro width
        screenHeight: 852.0,
      );

      final position = calculator.calculatePosition(
        index: 0,
        totalCards: 18,
        isVisible: true,
      );

      expect(position.x, isA<double>());
      expect(position.y, isA<double>());
      expect(position.angle, isA<double>());
      expect(position.zIndex, equals(18));
    });

    test('should return zero position when not visible', () {
      final calculator = FanCalculator(
        screenWidth: 393.0,
        screenHeight: 852.0,
      );

      final position = calculator.calculatePosition(
        index: 5,
        totalCards: 18,
        isVisible: false,
      );

      expect(position.x, equals(0));
      expect(position.y, equals(0));
      expect(position.angle, equals(0));
    });

    test('should calculate different positions for different indices', () {
      final calculator = FanCalculator(
        screenWidth: 393.0,
        screenHeight: 852.0,
      );

      final pos1 = calculator.calculatePosition(
        index: 0,
        totalCards: 18,
        isVisible: true,
      );
      final pos2 = calculator.calculatePosition(
        index: 17,
        totalCards: 18,
        isVisible: true,
      );

      expect(pos1.x, isNot(equals(pos2.x)));
      expect(pos1.angle, isNot(equals(pos2.angle)));
    });
  });
}
