import 'soul_card.dart';

class CardsData {
  static const List<SoulCard> allCards = [
    // EARTH
    SoulCard(
      id: "earth-1",
      suit: Suit.earth,
      rank: 1,
      symbol: "tree",
      divination: "Your body will break first",
    ),
    SoulCard(
      id: "earth-2",
      suit: Suit.earth,
      rank: 2,
      symbol: "tree",
      divination: "Take care of your body and it will take care of you",
    ),
    SoulCard(
      id: "earth-3",
      suit: Suit.earth,
      rank: 3,
      symbol: "tree",
      divination: "You can push through the pain",
    ),
    // WATER
    SoulCard(
      id: "water-1",
      suit: Suit.water,
      rank: 1,
      symbol: "wave",
      divination: "Your mind will fumble",
    ),
    SoulCard(
      id: "water-2",
      suit: Suit.water,
      rank: 2,
      symbol: "wave",
      divination: "Listen to your mind and it'll navigate",
    ),
    SoulCard(
      id: "water-3",
      suit: Suit.water,
      rank: 3,
      symbol: "wave",
      divination: "Rational and strategic decisions will come to you",
    ),
    // FIRE
    SoulCard(
      id: "fire-1",
      suit: Suit.fire,
      rank: 1,
      symbol: "flame",
      divination: "Will is weakened",
    ),
    SoulCard(
      id: "fire-2",
      suit: Suit.fire,
      rank: 2,
      symbol: "flame",
      divination: "Balance will with your circumstances",
    ),
    SoulCard(
      id: "fire-3",
      suit: Suit.fire,
      rank: 3,
      symbol: "flame",
      divination: "Focused will can shape outcomes",
    ),
    // AIR
    SoulCard(
      id: "air-1",
      suit: Suit.air,
      rank: 1,
      symbol: "wind",
      divination: "Spirit will break if you follow the path",
    ),
    SoulCard(
      id: "air-2",
      suit: Suit.air,
      rank: 2,
      symbol: "wind",
      divination: "Spirit will remain unaffected",
    ),
    SoulCard(
      id: "air-3",
      suit: Suit.air,
      rank: 3,
      symbol: "wind",
      divination: "Follow the path to nourish your spirit",
    ),
    // SPACE
    SoulCard(
      id: "space-1",
      suit: Suit.space,
      rank: 1,
      symbol: "diamond",
      divination: "A sense of exile or disconnection",
    ),
    SoulCard(
      id: "space-2",
      suit: Suit.space,
      rank: 2,
      symbol: "diamond",
      divination: "The location holds no significance. You are passing through",
    ),
    SoulCard(
      id: "space-3",
      suit: Suit.space,
      rank: 3,
      symbol: "diamond",
      divination: "Strong connection provides belonging and opportunity",
    ),
    // TIME
    SoulCard(
      id: "time-1",
      suit: Suit.time,
      rank: 1,
      symbol: "clock",
      divination: "Bad times are coming",
    ),
    SoulCard(
      id: "time-2",
      suit: Suit.time,
      rank: 2,
      symbol: "clock",
      divination: "Good times are coming",
    ),
    SoulCard(
      id: "time-3",
      suit: Suit.time,
      rank: 3,
      symbol: "clock",
      divination: "You are in the Good Times and it'll last",
    ),
  ];

  static List<SoulCard> shuffleCards() {
    final shuffled = List<SoulCard>.from(allCards);
    shuffled.shuffle();
    return shuffled;
  }
}
