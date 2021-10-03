import 'package:flutter/material.dart';

class MyInfo extends StatelessWidget {
  int score;
  int lives;

  MyInfo({required this.score, required this.lives});

  // ignore: non_constant_identifier_names
  var MyText = TextStyle(
      color: Colors.deepPurple,
      fontSize: 40,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -1),
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Score: $score',
            style: MyText,
          ),
          Text(
            'Lives: $lives',
            style: MyText,
          ),
        ],
      ),
    );
  }
}
