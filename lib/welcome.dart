import 'package:flutter/material.dart';
import 'dart:math';

/* 欢迎页需要通过网络请求获取数据 */

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WelcomeText('L'),
          WelcomeText('i'),
          WelcomeText('s'),
          WelcomeText('t'),
          WelcomeText('i'),
          WelcomeText('f'),
          WelcomeText('y'),
        ],
      ),
    );
  }
}

class AnimatedText extends AnimatedWidget {
  final String charactar;
  final Animation<double> curve;
  final Animation<double> shakeAnimation;
  AnimatedText(this.charactar, this.curve, this.shakeAnimation,
      {Key key, Animation<double> animation})
      : super(key: key, listenable: curve);

  Widget build(BuildContext context) {
    return new Center(
        child: Transform.translate(
      offset: Offset(0, curve.value * 70),
      child: Transform.rotate(
        //旋转90度
        angle: shakeAnimation.value,
        child: Text(this.charactar,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30.0,
              height: 1.2,
              decoration: TextDecoration.none,
            )),
      ),
    ));
  }
}

class WelcomeText extends StatefulWidget {
  final String charactar;
  WelcomeText(String charactar) : this.charactar = charactar;

  @override
  WelcomeTextState createState() => new WelcomeTextState(charactar);
}

class WelcomeTextState extends State<WelcomeText>
    with TickerProviderStateMixin {
  Animation<double> moveAnimation;
  Animation<double> shakeAnimation;
  Animation<double> curve;
  AnimationController moveController;
  AnimationController shakeController;

  final String charactar;
  WelcomeTextState(String charactar) : this.charactar = charactar;

  initState() {
    super.initState();

    moveController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    shakeController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);

    curve = CurvedAnimation(parent: moveController, curve: Curves.bounceOut);

    moveAnimation = Tween(begin: 0.0, end: 10.0).animate(moveController);
    shakeAnimation = Tween(begin: -0.15, end: 0.15).animate(shakeController);

    // 下落动画延迟
    var delay = 100 * Random().nextInt(10);
    Future.delayed(Duration(milliseconds: delay),() {
      moveController.forward();
    });

    // 抖动动画循环播放
    shakeAnimation.addListener(() {
      setState(() {});
    });
    shakeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        shakeController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        shakeController.forward();
      }
    });

    // 下落到底时停止抖动动画
    // moveController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     shakeController.dispose();
    //   } else if (status == AnimationStatus.dismissed) {
    //     shakeController.forward();
    //   }
    // });

    // 启动动画
    shakeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedText(
      charactar,
      curve,
      shakeAnimation,
      animation: moveAnimation,
    );
  }

  dispose() {
    moveController.dispose();
    super.dispose();
  }
}
