import 'package:flutter/material.dart';
import '../models/soul_card.dart';
import '../models/cards_data.dart';
import '../constants/app_constants.dart';
import '../widgets/card_fan.dart';
import '../widgets/card_reveal.dart';

enum DivinationState { idle, shuffling, fanned, revealing }

class DivinationScreen extends StatefulWidget {
  const DivinationScreen({super.key});

  @override
  State<DivinationScreen> createState() => _DivinationScreenState();
}

class _DivinationScreenState extends State<DivinationScreen> {
  DivinationState _state = DivinationState.idle;
  List<SoulCard> _shuffledCards = [];
  SoulCard? _selectedCard;
  bool _fanVisible = false;

  void _handleShuffle() {
    // Start shuffle animation
    setState(() {
      _shuffledCards = CardsData.shuffleCards();
      _state = DivinationState.shuffling;
      _fanVisible = false;
    });

    // After 0.5 seconds, transition to fanned state
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _state = DivinationState.fanned;
        });
        // Trigger fan animation
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() => _fanVisible = true);
          }
        });
      }
    });
  }

  void _handleCardSelected(SoulCard card) {
    setState(() {
      _selectedCard = card;
      _state = DivinationState.revealing;
    });
  }

  void _handleBackToFan() {
    setState(() {
      _state = DivinationState.fanned;
      _selectedCard = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          if (_state == DivinationState.revealing) {
            // Slide up and fade for reveal
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              ),
            );
          } else if (_state == DivinationState.shuffling) {
            // Fade for shuffling
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          } else if (_state == DivinationState.fanned) {
            // Fade in for fan
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          } else {
            // Fade for idle
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }
        },
        child: _buildCurrentState(),
      ),
    );
  }

  Widget _buildCurrentState() {
    if (_state == DivinationState.idle) {
      return _IdleStateView(
        key: const ValueKey('idle'),
        onShuffle: _handleShuffle,
      );
    }

    if (_state == DivinationState.shuffling) {
      return _ShufflingStateView(
        key: const ValueKey('shuffling'),
        cards: _shuffledCards,
      );
    }

    if (_state == DivinationState.fanned) {
      return _FannedStateView(
        key: const ValueKey('fanned'),
        cards: _shuffledCards,
        isVisible: _fanVisible,
        onCardSelected: _handleCardSelected,
        onShuffle: _handleShuffle,
      );
    }

    // Revealing state
    return CardReveal(
      key: ValueKey('reveal-${_selectedCard!.id}'),
      card: _selectedCard!,
      onBack: _handleBackToFan,
    );
  }
}

class _IdleStateView extends StatefulWidget {
  final VoidCallback onShuffle;

  const _IdleStateView({
    super.key,
    required this.onShuffle,
  });

  @override
  State<_IdleStateView> createState() => _IdleStateViewState();
}

class _IdleStateViewState extends State<_IdleStateView>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: _AnimatedShuffleButton(
          onPressed: widget.onShuffle,
        ),
      ),
    );
  }
}

class _AnimatedShuffleButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AnimatedShuffleButton({required this.onPressed});

  @override
  State<_AnimatedShuffleButton> createState() => _AnimatedShuffleButtonState();
}

class _AnimatedShuffleButtonState extends State<_AnimatedShuffleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1.0 - (_controller.value * 0.05);
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A3E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF7EC8E3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7EC8E3).withOpacity(
                      _isPressed ? 0.3 : 0.2,
                    ),
                    blurRadius: _isPressed ? 16 : 8,
                    spreadRadius: _isPressed ? 2 : 0,
                  ),
                ],
              ),
              child: const Text(
                'Shuffle',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cinzel',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ShufflingStateView extends StatefulWidget {
  final List<SoulCard> cards;

  const _ShufflingStateView({
    super.key,
    required this.cards,
  });

  @override
  State<_ShufflingStateView> createState() => _ShufflingStateViewState();
}

class _ShufflingStateViewState extends State<_ShufflingStateView>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _rotations;
  late List<Animation<Offset>> _positions;

  @override
  void initState() {
    super.initState();
    final cardCount = widget.cards.length;
    _controllers = List.generate(
      cardCount,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );

    _rotations = _controllers.asMap().entries.map((entry) {
      final index = entry.key;
      final controller = entry.value;
      // Vary rotation amount for each card
      final rotationAmount = 180.0 + (index % 3) * 60.0; // 180, 240, or 300 degrees
      return Tween<double>(begin: 0.0, end: rotationAmount).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    _positions = _controllers.asMap().entries.map((entry) {
      final index = entry.key;
      final controller = entry.value;
      // Create random movement pattern for each card
      final random = (index * 17 + 23) % 100 / 100.0; // Pseudo-random based on index
      final random2 = (index * 31 + 47) % 100 / 100.0; // Second random for more variation
      return Tween<Offset>(
        begin: Offset.zero,
        end: Offset(
          (random - 0.5) * 150,
          (random2 - 0.5) * 150,
        ),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Start all animations - play once forward
    for (var controller in _controllers) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 430;
    final baseCardWidth = isMobile ? AppConstants.mobileCardWidth : AppConstants.cardWidth;
    final baseCardHeight = isMobile ? AppConstants.mobileCardHeight : AppConstants.cardHeight;

    return Container(
      width: size.width,
      height: size.height,
      color: AppConstants.backgroundColor,
      child: Stack(
        children: widget.cards.asMap().entries.map((entry) {
          final index = entry.key;
          final card = entry.value;
          return Center(
            child: AnimatedBuilder(
              animation: _controllers[index],
              builder: (context, child) {
                return Transform.translate(
                  offset: _positions[index].value,
                    child: Transform.rotate(
                      angle: _rotations[index].value * 3.14159 / 180,
                      child: Opacity(
                        opacity: 0.8,
                        child: Transform.scale(
                          scale: 0.5,
                          child: SizedBox(
                            width: baseCardWidth * 0.5,
                            height: baseCardHeight * 0.5,
                            child: widget.cards[index].suit == Suit.space ||
                                    widget.cards[index].suit == Suit.time
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: AppConstants.getSuitColor(card.suit),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppConstants.getSuitColor(card.suit),
                                        width: 2,
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: AppConstants.getSuitColor(card.suit),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFF7EC8E3).withOpacity(0.5),
                                        width: 2,
                                      ),
                                    ),
                                  ),
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
    );
  }
}

class _FannedStateView extends StatelessWidget {
  final List<SoulCard> cards;
  final bool isVisible;
  final ValueChanged<SoulCard> onCardSelected;
  final VoidCallback onShuffle;

  const _FannedStateView({
    super.key,
    required this.cards,
    required this.isVisible,
    required this.onCardSelected,
    required this.onShuffle,
  });

  Future<void> _handleRefresh() async {
    onShuffle();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: const Color(0xFF7EC8E3),
      backgroundColor: const Color(0xFF2A2A3E),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                CardFan(
                  cards: cards,
                  isVisible: isVisible,
                  onCardSelected: onCardSelected,
                  onShuffle: onShuffle,
                ),
                // Banner overlay
                SafeArea(
                  child: Column(
                    children: [
                      // Soul Cards Banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppConstants.backgroundColor,
                              AppConstants.backgroundColor.withOpacity(0.0),
                            ],
                          ),
                        ),
                        child: Text(
                          'Soul Cards',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cinzel',
                            color: const Color(0xFF7EC8E3),
                            letterSpacing: 3,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
