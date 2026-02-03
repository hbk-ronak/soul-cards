import 'package:flutter/material.dart';
import '../models/soul_card.dart';
import '../utils/fan_calculator.dart';
import '../constants/app_constants.dart';
import 'soul_card_widget.dart';

class CardFan extends StatefulWidget {
  final List<SoulCard> cards;
  final bool isVisible;
  final ValueChanged<SoulCard> onCardSelected;
  final VoidCallback? onShuffle;

  const CardFan({
    super.key,
    required this.cards,
    required this.isVisible,
    required this.onCardSelected,
    this.onShuffle,
  });

  @override
  State<CardFan> createState() => _CardFanState();
}

class _CardFanState extends State<CardFan> with TickerProviderStateMixin {
  late FanCalculator _calculator;
  String? _hoveredCardId;
  double _dragDistance = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      _calculator = FanCalculator(
        screenWidth: size.width,
        screenHeight: size.height,
      );
    });
  }

  void _handleCardHover(bool isHovered, SoulCard card) {
    setState(() {
      _hoveredCardId = isHovered ? card.id : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 430;
    final baseCardWidth = isMobile ? AppConstants.mobileCardWidth : AppConstants.cardWidth;
    final baseCardHeight = isMobile ? AppConstants.mobileCardHeight : AppConstants.cardHeight;
    
    // Scale factor for cards in fanout (make them smaller - reduced further)
    final fanScale = isMobile ? 0.6 : 0.65;
    final cardHeight = baseCardHeight * fanScale;
    
    _calculator = FanCalculator(
      screenWidth: size.width,
      screenHeight: size.height,
    );

    return GestureDetector(
      onPanStart: (details) {
        if (widget.isVisible && widget.onShuffle != null) {
          setState(() {
            _isDragging = true;
            _dragDistance = 0.0;
          });
        }
      },
      onPanUpdate: (details) {
        if (widget.isVisible && widget.onShuffle != null && _isDragging) {
          setState(() {
            // Track total drag distance in any direction
            _dragDistance += (details.delta.dx.abs() + details.delta.dy.abs());
          });
        }
      },
      onPanEnd: (details) {
        if (widget.isVisible && widget.onShuffle != null && _isDragging) {
          // Trigger shuffle if dragged enough (threshold: 100 pixels)
          if (_dragDistance > 100) {
            widget.onShuffle?.call();
          }
          setState(() {
            _isDragging = false;
            _dragDistance = 0.0;
          });
        }
      },
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(bottom: isMobile ? 16 : 32),
        child: Stack(
          clipBehavior: isMobile ? Clip.none : Clip.hardEdge,
        children: widget.cards.asMap().entries.map((entry) {
          final index = entry.key;
          final card = entry.value;
          final position = _calculator.calculatePosition(
            index: index,
            totalCards: widget.cards.length,
            isVisible: widget.isVisible,
          );
          final isHovered = _hoveredCardId == card.id;

          return Positioned(
            left: size.width / 2 - baseCardWidth / 2,
            // Pull cards up more - show most of the card (only bottom 1/4 hidden)
            bottom: -cardHeight / 4,
            child: TweenAnimationBuilder<double>(
              duration: AppConstants.fanAnimationDuration +
                  (AppConstants.staggerDelay * index),
              curve: Curves.easeOut,
              tween: Tween(begin: 0.0, end: widget.isVisible ? 1.0 : 0.0),
              builder: (context, value, child) {
                final currentX = position.x * value;
                final currentY = position.y * value;
                final currentAngle = position.angle * value;
                // Scale animation - cards start at full size, scale down when fanned
                final currentScale = 1.0 - (1.0 - fanScale) * value;
                
                return Transform.translate(
                  offset: Offset(currentX, -currentY),
                  child: Transform.rotate(
                    angle: currentAngle * 3.14159 / 180,
                    alignment: Alignment.bottomCenter,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, isHovered ? (isMobile ? -15 : -20) : 0)
                        ..scale(isHovered ? (isMobile ? 1.12 : 1.15) * currentScale : currentScale),
                      alignment: Alignment.center,
                      child: Hero(
                        tag: 'card-${card.id}',
                        flightShuttleBuilder: (
                          BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext,
                        ) {
                          final Hero toHero = toHeroContext.widget as Hero;
                          return RotationTransition(
                            turns: animation,
                            child: toHero.child,
                          );
                        },
                        child: SoulCardWidget(
                          card: card,
                          isInteractive: widget.isVisible,
                          onTap: () => widget.onCardSelected(card),
                          onHover: (hovered) => _handleCardHover(hovered, card),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        ),
      ),
    );
  }
}
