import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  late final icon;
  late final function;

  MyButton({
    @required this.icon,
    @required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.grey[100],
          width: 50,
          height: 50,
          child: Center(
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
