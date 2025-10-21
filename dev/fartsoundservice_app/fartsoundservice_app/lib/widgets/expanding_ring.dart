import 'package:flutter/material.dart';

class ExpandingRing extends StatefulWidget {
  final double duration;
  final double lineWidth;

  const ExpandingRing({
    super.key,
    this.duration = 0.7,
    this.lineWidth = 8,
  });

  @override
  State<ExpandingRing> createState() => _ExpandingRingState();
}

class _ExpandingRingState extends State<ExpandingRing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.duration * 1000).toInt()),
    );

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.30, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
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
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withAlpha((255 * _opacityAnimation.value).round()),
                width: widget.lineWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}