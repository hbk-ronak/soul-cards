import 'package:flutter/material.dart';
import '../models/soul_card.dart';

class AppConstants {
  // Card dimensions (2:3 ratio, optimized for iPhone)
  static const double cardWidth = 200.0;
  static const double cardHeight = 300.0;
  
  // Mobile card dimensions
  static const double mobileCardWidth = 160.0;
  static const double mobileCardHeight = 240.0;
  
  // Animation durations
  static const Duration fanAnimationDuration = Duration(milliseconds: 600);
  static const Duration cardFlipDuration = Duration(milliseconds: 600);
  static const Duration staggerDelay = Duration(milliseconds: 50);
  
  // Suit colors
  static const Color suitEarth = Color(0xFF8B5E3C);
  static const Color suitWater = Color(0xFF1A3A5C);
  static const Color suitFire = Color(0xFFC0392B);
  static const Color suitAir = Color(0xFF7EC8E3);
  static const Color suitSpace = Color(0xFF1A1A2E);
  static const Color suitTime = Color(0xFFF0F0F0);
  
  // Background color
  static const Color backgroundColor = Color(0xFF1A1A2E);
  
  // Text colors for each suit
  static const Color textOnEarth = Colors.white;
  static const Color textOnWater = Colors.white;
  static const Color textOnFire = Colors.white;
  static const Color textOnAir = Color(0xFF1A1A2E);
  static const Color textOnSpace = Colors.white;
  static const Color textOnTime = Color(0xFF1A1A2E);
  
  // Suit name mappings
  static const Map<Suit, String> suitNames = {
    Suit.earth: 'EARTH',
    Suit.water: 'WATER',
    Suit.fire: 'FIRE',
    Suit.air: 'AIR',
    Suit.space: 'SPACE',
    Suit.time: 'TIME',
  };
  
  static Color getSuitColor(Suit suit) {
    switch (suit) {
      case Suit.earth:
        return suitEarth;
      case Suit.water:
        return suitWater;
      case Suit.fire:
        return suitFire;
      case Suit.air:
        return suitAir;
      case Suit.space:
        return suitSpace;
      case Suit.time:
        return suitTime;
    }
  }
  
  static Color getTextColor(Suit suit) {
    switch (suit) {
      case Suit.earth:
        return textOnEarth;
      case Suit.water:
        return textOnWater;
      case Suit.fire:
        return textOnFire;
      case Suit.air:
        return textOnAir;
      case Suit.space:
        return textOnSpace;
      case Suit.time:
        return textOnTime;
    }
  }
  
  static String getSuitName(Suit suit) {
    return suitNames[suit] ?? '';
  }
}
