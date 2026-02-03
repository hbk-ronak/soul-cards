import 'package:flutter_test/flutter_test.dart';
import 'package:soul_cards/models/soul_card.dart';
import 'package:soul_cards/models/cards_data.dart';

void main() {
  group('SoulCard', () {
    test('should have all 18 cards', () {
      expect(CardsData.allCards.length, equals(18));
    });

    test('should have 3 cards per suit', () {
      final earthCards = CardsData.allCards
          .where((card) => card.suit == Suit.earth)
          .length;
      expect(earthCards, equals(3));
    });

    test('should have ranks 1, 2, 3 for each suit', () {
      for (final suit in Suit.values) {
        final suitCards = CardsData.allCards
            .where((card) => card.suit == suit)
            .toList();
        expect(suitCards.length, equals(3));
        expect(suitCards.map((c) => c.rank).toSet(), equals({1, 2, 3}));
      }
    });

    test('shuffleCards should return all cards', () {
      final shuffled = CardsData.shuffleCards();
      expect(shuffled.length, equals(18));
      expect(shuffled.toSet().length, equals(18));
    });
  });
}
