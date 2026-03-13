import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Earthbound-style wavy chat bubble decoration
class EarthboundBubbleDecoration extends BoxDecoration {
  EarthboundBubbleDecoration({
    required Color backgroundColor,
    required bool isSent,
    bool wavy = true,
  }) : super(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isSent ? 18 : 4),
            bottomRight: Radius.circular(isSent ? 4 : 18),
          ),
          border: Border.all(
            color: isSent
                ? const Color(0xFF4A9ED4) // Darker blue for sent
                : const Color(0xFFE58A9E), // Darker pink for received
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        );
}

/// Custom painter for wavy Earthbound-style borders
class WavyBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool isTop;
  
  WavyBorderPainter({
    required this.color,
    this.strokeWidth = 2,
    this.isTop = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final waveHeight = 4.0;
    final waveLength = 12.0;
    
    if (isTop) {
      path.moveTo(0, waveHeight);
      for (double x = 0; x < size.width; x += waveLength) {
        path.quadraticBezierTo(
          x + waveLength / 2,
          isTop ? -waveHeight : waveHeight,
          x + waveLength,
          0,
        );
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Star pattern decoration for backgrounds
class StarPatternDecoration extends Decoration {
  final Color starColor;
  final double starSize;
  final double density;
  
  const StarPatternDecoration({
    this.starColor = const Color(0xFFFFD93D), // Golden yellow
    this.starSize = 3.0,
    this.density = 0.05,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _StarPatternBoxPainter(
      starColor: starColor,
      starSize: starSize,
      density: density,
    );
  }
}

class _StarPatternBoxPainter extends BoxPainter {
  final Color starColor;
  final double starSize;
  final double density;
  final math.Random _random = math.Random(42); // Fixed seed for consistency

  _StarPatternBoxPainter({
    required this.starColor,
    required this.starSize,
    required this.density,
  });

  @override
  void paint(Canvas canvas, Size size, ImageConfiguration configuration) {
    final rect = configuration.rect ?? Rect.fromLTWH(0, 0, size.width, size.height);
    
    final paint = Paint()
      ..color = starColor.withAlpha(40)
      ..style = PaintingStyle.fill;

    final starCount = (size.width * size.height * density).toInt();
    
    for (int i = 0; i < starCount; i++) {
      final x = _random.nextDouble() * size.width;
      final y = _random.nextDouble() * size.height;
      final starS = starSize * (0.5 + _random.nextDouble() * 0.5);
      
      // Draw simple 4-point star
      canvas.drawLine(
        Offset(x, y - starS),
        Offset(x, y + starS),
        paint..strokeWidth = 1,
      );
      canvas.drawLine(
        Offset(x - starS, y),
        Offset(x + starS, y),
        paint..strokeWidth = 1,
      );
    }
  }
}

/// Earthbound-styled chat bubble wrapper
class EarthboundChatBubble extends StatelessWidget {
  final Widget child;
  final bool isSent;
  final Color? backgroundColor;
  final bool showWavyBorder;
  final bool showStars;
  
  const EarthboundChatBubble({
    super.key,
    required this.child,
    required this.isSent,
    this.backgroundColor,
    this.showWavyBorder = true,
    this.showStars = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    
    // Default Earthbound colors
    final bubbleColor = isSent
        ? (isLight ? const Color(0xFF64B5F6) : const Color(0xFF2D4A5A))
        : (isLight ? const Color(0xFFFF9EAA) : const Color(0xFF4A3A3F));
    
    final bgColor = backgroundColor ?? bubbleColor;
    
    return Container(
      decoration: EarthboundBubbleDecoration(
        backgroundColor: bgColor,
        isSent: isSent,
        wavy: showWavyBorder,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: child,
    );
  }
}

/// Earthbound text box decoration (like the CTB text boxes)
class EarthboundTextBoxDecoration extends BoxDecoration {
  EarthboundTextBoxDecoration({
    bool isDark = false,
  }) : super(
          color: isDark ? const Color(0xFF2D2A1F) : const Color(0xFFFCEEB4),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isDark ? const Color(0xFF4A4235) : const Color(0xFFFF6B35),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 0,
              offset: const Offset(3, 3),
            ),
          ],
        );
}

/// Earthbound-styled button
class EarthboundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isPrimary;
  
  const EarthboundButton({
    super.key,
    this.onPressed,
    required this.child,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF7CB342) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isPrimary 
            ? null 
            : Border.all(color: const Color(0xFFFF6B35), width: 2),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: const Color(0xFF7CB342).withAlpha(80),
                  blurRadius: 0,
                  offset: const Offset(2, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: DefaultTextStyle(
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFFFF6B35),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// PSI power flash effect widget (for notifications)
class PSIFlashEffect extends StatefulWidget {
  final Widget child;
  final bool active;
  final Color flashColor;
  
  const PSIFlashEffect({
    super.key,
    required this.child,
    this.active = false,
    this.flashColor = const Color(0xFFBA68C8), // Purple PSI color
  });

  @override
  State<PSIFlashEffect> createState() => _PSIFlashEffectState();
}

class _PSIFlashEffectState extends State<PSIFlashEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    if (widget.active) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(PSIFlashEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _controller.forward(from: 0);
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
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            border: widget.active
                ? Border.all(
                    color: widget.flashColor.withAlpha((_animation.value * 150).toInt()),
                    width: 2,
                  )
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        );
      },
    );
  }
}
