import 'package:flutter/material.dart';

class MyBullet extends StatelessWidget {
  final bulletX;
  final bulletHeight;

  MyBullet({this.bulletX, this.bulletHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(bulletX, 1),
      child: Container(
        width: 2,
        height: bulletHeight,
        color: Colors.grey,
      ),
    );
  }
}
