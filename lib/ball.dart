import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;

  Ball({required this.ballX, required this.ballY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
