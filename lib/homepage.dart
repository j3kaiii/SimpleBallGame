import 'dart:async';

import 'package:bubble/ball.dart';
import 'package:bubble/button.dart';
import 'package:bubble/info.dart';
import 'package:bubble/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bullet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  // Проверяем, запущена ли игра
  bool isGameRun = false;

  // Положение игрока на старте
  static double playerX = 0;

  // Переменные выстрелов
  // Снаряд там-же, где игрок
  double bulletX = playerX;
  double bulletY = 1;
  // Высота снаряда на старте
  double bulletHeight = 30;
  // Снаряд летит?
  bool isShooting = false;

  // Переменные шарика
  double ballX = 0.5;
  double ballY = 1;
  var ballDirection = direction.LEFT;
  double velocity = 70;
  int speed = 10;

  bool isResetBall = false;
  int score = 0;
  int lives = 3;

  // Запускается игра, шарик полетел
  void startGame() {
    isGameRun = true;

    double time = 0;
    double height = 0;

    Timer.periodic(Duration(milliseconds: speed), (timer) {
      // Высота шарика
      height = -5 * time * time + velocity * time;
      if (height < 0) {
        time = 0;
      }
      setState(() {
        ballY = heightToCoordinate(height);
      });

      // На границе экрана меняем направление движения шарика
      if (ballX - 0.01 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.01 > 1) {
        ballDirection = direction.LEFT;
      }

      // Движение шарика
      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.01;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.01;
        });
      }

      // Если игра не запущена, шарик не двигается
      if (!isGameRun) timer.cancel();

      // Если игрок умер
      if (playerDies()) {
        ballX = 1;
        ballY = 1;
        playerX = -1;
        resetBullet();
        lives -= 1;
        // Если жизней совсем не осталось
        if (lives == 0) {
          isGameRun = false;
          timer.cancel();
          _showDialog();
        }
      }

      time += 0.1;
    });
  }

  // Движение игрока НАЛЕВО
  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
      } else {
        playerX -= 0.1;
      }

      // Если снаряд не запущен, двигаем его вместе с игроком
      if (!isShooting) {
        bulletX = playerX;
      }
    });
  }

  // Движение игррока НАПРАВО
  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
      } else {
        playerX += 0.1;
      }

      // Если снаряд не запущен, двигаем его вместе с игроком
      if (!isShooting) {
        bulletX = playerX;
      }
    });
  }

  // Пробуем стрелять
  void fire() {
    // Если снаряд не запущен
    if (isShooting == false) {
      Timer.periodic(Duration(milliseconds: 20), (timer) {
        // Стреляем
        isShooting = true;

        // Снаряд летит ВВЕРХ
        setState(() {
          bulletHeight += 10;
        });

        // Когда снаряд долетел до верха экрана
        if (bulletHeight > MediaQuery.of(context).size.height * 3 / 4) {
          // Сбрасываем значения снаряда
          resetBullet();
          timer.cancel();
          // И можем снова стрелять
          isShooting = false;
        }

        // Если снаряд столкнулся с мячиком
        if (ballY > heightToCoordinate(bulletHeight) &&
            (ballX - bulletX).abs() < 0.03) {
          resetBullet();
          ballY = 1;
          ballX = 1;
          timer.cancel();
          score += 1;
          isShooting = false;
        }
      });
    }
  }

  // Если шарик попал по игроку
  bool playerDies() {
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  void resetGame() {
    isGameRun = false;
  }

  void resetBullet() {
    bulletX = playerX;
    bulletHeight = 10;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.orange,
          title: Center(
            child: Column(
              children: [
                Text('You died'),
                Text('You got $score points'),
              ],
            ),
          ),
        );
      },
    );
  }

  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double bulletY = 1 - 2 * height / totalHeight;
    return bulletY;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fire();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.pink[100],
              child: Center(
                child: Stack(
                  children: [
                    Ball(ballX: ballX, ballY: ballY),
                    MyBullet(
                      bulletX: bulletX,
                      bulletHeight: bulletHeight,
                    ),
                    Player(playerX: playerX),
                    MyInfo(score: score, lives: lives)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  !isGameRun
                      ? MyButton(
                          icon: Icons.play_arrow,
                          function: startGame,
                        )
                      : MyButton(
                          icon: Icons.cancel_outlined,
                          function: resetGame,
                        ),
                  MyButton(
                    icon: Icons.arrow_back,
                    function: moveLeft,
                  ),
                  MyButton(
                    icon: Icons.arrow_upward,
                    function: fire,
                  ),
                  MyButton(
                    icon: Icons.arrow_forward,
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
