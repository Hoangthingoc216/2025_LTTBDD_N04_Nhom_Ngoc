import 'dart:math';
import 'package:flutter/material.dart';

class FlashcardWidget extends StatelessWidget {
  final String frontText;
  final String backText;
  final bool isFront;
  final Animation<double> animation;

  const FlashcardWidget({
    super.key,
    required this.frontText,
    required this.backText,
    required this.isFront,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final angle = animation.value * pi;
    final isUnder = angle > (pi / 2);
    final displayedText = isUnder ? backText : frontText;
    final isReversed = isUnder;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle),
      child: Container(
        width: 400,
        height: 250,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
        ),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateY(isReversed ? pi : 0),
          child: Text(
            displayedText,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
