export type Suit = "earth" | "water" | "fire" | "air" | "space" | "time";

export interface SoulCard {
  id: string;
  suit: Suit;
  rank: 1 | 2 | 3;
  symbol: string;
  divination: string;
}

export const allCards: SoulCard[] = [
  // EARTH
  {
    id: "earth-1",
    suit: "earth",
    rank: 1,
    symbol: "tree",
    divination: "Your body will break first"
  },
  {
    id: "earth-2",
    suit: "earth",
    rank: 2,
    symbol: "tree",
    divination: "Take care of your body and it will take care of you"
  },
  {
    id: "earth-3",
    suit: "earth",
    rank: 3,
    symbol: "tree",
    divination: "You can push through the pain"
  },
  // WATER
  {
    id: "water-1",
    suit: "water",
    rank: 1,
    symbol: "wave",
    divination: "Your mind will fumble"
  },
  {
    id: "water-2",
    suit: "water",
    rank: 2,
    symbol: "wave",
    divination: "Listen to your mind and it'll navigate"
  },
  {
    id: "water-3",
    suit: "water",
    rank: 3,
    symbol: "wave",
    divination: "Rational and strategic decisions will come to you"
  },
  // FIRE
  {
    id: "fire-1",
    suit: "fire",
    rank: 1,
    symbol: "flame",
    divination: "Will is weakened"
  },
  {
    id: "fire-2",
    suit: "fire",
    rank: 2,
    symbol: "flame",
    divination: "Balance will with your circumstances"
  },
  {
    id: "fire-3",
    suit: "fire",
    rank: 3,
    symbol: "flame",
    divination: "Focused will can shape outcomes"
  },
  // AIR
  {
    id: "air-1",
    suit: "air",
    rank: 1,
    symbol: "wind",
    divination: "Spirit will break if you follow the path"
  },
  {
    id: "air-2",
    suit: "air",
    rank: 2,
    symbol: "wind",
    divination: "Spirit will remain unaffected"
  },
  {
    id: "air-3",
    suit: "air",
    rank: 3,
    symbol: "wind",
    divination: "Follow the path to nourish your spirit"
  },
  // SPACE
  {
    id: "space-1",
    suit: "space",
    rank: 1,
    symbol: "diamond",
    divination: "A sense of exile or disconnection"
  },
  {
    id: "space-2",
    suit: "space",
    rank: 2,
    symbol: "diamond",
    divination: "The location holds no significance. You are passing through"
  },
  {
    id: "space-3",
    suit: "space",
    rank: 3,
    symbol: "diamond",
    divination: "Strong connection provides belonging and opportunity"
  },
  // TIME
  {
    id: "time-1",
    suit: "time",
    rank: 1,
    symbol: "clock",
    divination: "Bad times are coming"
  },
  {
    id: "time-2",
    suit: "time",
    rank: 2,
    symbol: "clock",
    divination: "Good times are coming"
  },
  {
    id: "time-3",
    suit: "time",
    rank: 3,
    symbol: "clock",
    divination: "You are in the Good Times and it'll last"
  }
];
