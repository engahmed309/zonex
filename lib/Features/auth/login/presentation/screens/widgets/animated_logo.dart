import 'package:flutter/material.dart';
import 'package:zonex/core/utils/constants.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Color(0xff49D0A0).withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_animation.value, 0), // حركة يمين وشمال
              child: child,
            );
          },
          child: Center(
            child: Text(
              "ZoneX",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
