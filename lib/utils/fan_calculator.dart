import 'dart:math' as math;

class FanCalculator {
  final double screenWidth;
  final double screenHeight;
  
  FanCalculator({
    required this.screenWidth,
    required this.screenHeight,
  });
  
  FanPosition calculatePosition({
    required int index,
    required int totalCards,
    required bool isVisible,
  }) {
    if (!isVisible) {
      return FanPosition(
        x: 0,
        y: 0,
        angle: 0,
        zIndex: totalCards - index,
      );
    }
    
    // Replicate Vue implementation exactly
    final isMobile = screenWidth <= 430;
    final baseCardWidth = isMobile ? 100.0 : 200.0;
    final baseCardHeight = isMobile ? 150.0 : 300.0;
    // Narrower fanout angle for tighter spread
    final totalArcAngle = isMobile ? 45.0 : 90.0;
    
    // Cards are scaled down in fanout state (reduced further)
    final fanScale = isMobile ? 0.6 : 0.65;
    final cardWidth = baseCardWidth * fanScale;
    final cardHeight = baseCardHeight * fanScale;
    
    // Calculate safe radius to prevent overflow
    // Account for card width when rotated around bottom center
    final padding = isMobile ? 10.0 : 40.0;
    final cardHalfWidth = cardWidth / 2;
    final maxAngleRad = (totalArcAngle * math.pi) / 360; // half angle in radians
    
    // When a card is rotated, its bounding box extends horizontally
    // For a card rotated by angle θ around bottom center:
    // The leftmost point extends: -cardHalfWidth * cos(θ) - cardHeight * sin(θ) (if θ > 0)
    // The rightmost point extends: cardHalfWidth * cos(θ) + cardHeight * sin(θ) (if θ > 0)
    // For the leftmost card (negative angle), we need to account for the left extension
    // For the rightmost card (positive angle), we need to account for the right extension
    final maxRotatedExtension = cardHalfWidth * math.cos(maxAngleRad) + 
                                cardHeight * math.sin(maxAngleRad);
    
    // Maximum horizontal reach from center before card extends beyond viewport
    final maxHorizontalReach = (screenWidth - padding) / 2 - maxRotatedExtension;
    
    // Calculate radius based on arc angle and max horizontal reach
    // x = sin(angle) * radius, so radius = x / sin(angle)
    // Reduce radius to make arc length longer (cards closer to center, more spread along arc)
    final calculatedRadius = maxHorizontalReach / math.sin(maxAngleRad);
    final maxRadius = isMobile ? 100.0 : 200.0; // Reduced from 140/280
    final safeRadius = math.min(calculatedRadius, maxRadius);
    
    // Apply additional reduction factor to make radius even shorter
    final radiusMultiplier = 0.7; // Reduce radius by 30%
    final radius = safeRadius * radiusMultiplier;
    
    final startAngle = -totalArcAngle / 2;
    final angleStep = totalCards > 1 ? totalArcAngle / (totalCards - 1) : 0;
    final angle = startAngle + index * angleStep;
    final radians = (angle * math.pi) / 180;
    
    // Exact Vue calculation: x = sin(radians) * radius, y = -cos(radians) * radius
    final x = math.sin(radians) * radius;
    final y = -math.cos(radians) * radius;
    
    return FanPosition(
      x: x,
      y: y,
      angle: angle,
      zIndex: totalCards - index,
    );
  }
}

class FanPosition {
  final double x;
  final double y;
  final double angle;
  final int zIndex;
  
  const FanPosition({
    required this.x,
    required this.y,
    required this.angle,
    required this.zIndex,
  });
}
