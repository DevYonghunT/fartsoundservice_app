import 'dart:math';
import 'package:flutter/material.dart';

class RainbowBorderView extends StatefulWidget {
  final bool isAnimating;

  const RainbowBorderView({super.key, required this.isAnimating});

  @override
  State<RainbowBorderView> createState() => _RainbowBorderViewState();
}

class _RainbowBorderViewState extends State<RainbowBorderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void didUpdateWidget(covariant RainbowBorderView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating && !oldWidget.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isAnimating ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _RainbowPainter(rotation: _controller.value * 2 * pi),
            child: Container(),
          );
        },
      ),
    );
  }
}

class _RainbowPainter extends CustomPainter {
  final double rotation;

  _RainbowPainter({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(center: center, width: size.width, height: size.height);
    
    final paint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.cyan,
          Colors.blue, Colors.purple, Colors.pink, Colors.red,
        ],
        startAngle: 0.0,
        endAngle: 2 * pi,
        transform: GradientRotation(rotation),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(size.width * 0.1));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}