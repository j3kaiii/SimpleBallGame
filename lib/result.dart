import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;

  // ignore: non_constant_identifier_names
  var MyText = TextStyle(
      color: Colors.deepPurple,
      fontSize: 40,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  Result(this.score);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        flex: 3,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are dead', style: MyText),
              Text('You got $score points', style: MyText),
            ],
          ),
        ),
      ),
    );
  }
}
