import 'package:flutter/material.dart';
import '../models/soul_card.dart';
import '../constants/app_constants.dart';

class SoulCardWidget extends StatefulWidget {
  final SoulCard card;
  final bool isFlipped;
  final bool isInteractive;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onHover;

  const SoulCardWidget({
    super.key,
    required this.card,
    this.isFlipped = false,
    this.isInteractive = true,
    this.onTap,
    this.onHover,
  });

  @override
  State<SoulCardWidget> createState() => _SoulCardWidgetState();
}

class _SoulCardWidgetState extends State<SoulCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.isInteractive) {
      setState(() => _isHovered = true);
      _hoverController.forward();
      widget.onHover?.call(true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.isInteractive) {
      setState(() => _isHovered = false);
      _hoverController.reverse();
      widget.onHover?.call(false);
      widget.onTap?.call();
    }
  }

  void _handleTapCancel() {
    if (widget.isInteractive) {
      setState(() => _isHovered = false);
      _hoverController.reverse();
      widget.onHover?.call(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final suitColor = AppConstants.getSuitColor(widget.card.suit);
    final textColor = AppConstants.getTextColor(widget.card.suit);
    final suitName = AppConstants.getSuitName(widget.card.suit);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          final scale = 1.0 + (_hoverController.value * 0.15);
          final translateY = -(_hoverController.value * 20);
          final brightness = 1.0 + (_hoverController.value * 0.2);

          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0, translateY)
              ..scale(scale),
            alignment: Alignment.center,
            child: Container(
              width: AppConstants.cardWidth,
              height: AppConstants.cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? const Color(0xFF7EC8E3).withOpacity(0.4)
                        : Colors.black.withOpacity(0.3),
                    blurRadius: _isHovered ? 32 : 12,
                    spreadRadius: _isHovered ? 4 : 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _CardFlipWidget(
                  isFlipped: widget.isFlipped,
                  front: _CardFront(
                    suitColor: suitColor,
                    textColor: textColor,
                    suitName: suitName,
                    rank: widget.card.rank,
                    divination: widget.card.divination,
                    brightness: brightness,
                  ),
                  back: const _CardBack(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  final Color suitColor;
  final Color textColor;
  final String suitName;
  final int rank;
  final String divination;
  final double brightness;

  const _CardFront({
    required this.suitColor,
    required this.textColor,
    required this.suitName,
    required this.rank,
    required this.divination,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.lerp(
          suitColor,
          suitColor.withOpacity(1.0),
          brightness.clamp(0.0, 1.0),
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$rank',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  suitName,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                divination,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF2A2A3E),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _BackPatternPainter(),
            ),
          ),
          // Circle
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1;

    for (int i = 0; i < size.width + size.height; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(0, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardFlipWidget extends StatefulWidget {
  final bool isFlipped;
  final Widget front;
  final Widget back;

  const _CardFlipWidget({
    required this.isFlipped,
    required this.front,
    required this.back,
  });

  @override
  State<_CardFlipWidget> createState() => _CardFlipWidgetState();
}

class _CardFlipWidgetState extends State<_CardFlipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.cardFlipDuration,
    );
    if (widget.isFlipped) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_CardFlipWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 3.14159; // 0 to π
        final isFrontVisible = _controller.value > 0.5;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(angle),
          child: isFrontVisible
              ? Transform(
                  alignment: Alignment.center,
                  // Un-mirror the front face text
                  transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                  child: widget.front,
                )
              : widget.back,
        );
      },
    );
  }
}
