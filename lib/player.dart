import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  late final playerX;

  Player({
    @required this.playerX,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: Container(
        color: Colors.blue,
        height: 50,
        width: 50,
      ),
    );
  }
}
