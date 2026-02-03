enum Suit {
  earth,
  water,
  fire,
  air,
  space,
  time,
}

class SoulCard {
  final String id;
  final Suit suit;
  final int rank; // 1, 2, or 3
  final String symbol;
  final String divination;

  const SoulCard({
    required this.id,
    required this.suit,
    required this.rank,
    required this.symbol,
    required this.divination,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoulCard &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
