import 'package:flutter/material.dart';

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
  AnimatedText(this.charactar, {Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    // final String charactar = 'LL';
    return new Center(
      child: Transform.translate(
            offset: Offset(0, animation.value),
            child: Text(this.charactar,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30.0,
                height: 1.2,
                decoration: TextDecoration.none,
              )
            ),
          )
    );
  }
}

class WelcomeText extends StatefulWidget {
  final String charactar;
  WelcomeText(String charactar): this.charactar = charactar;

  @override
  WelcomeTextState createState() => new WelcomeTextState(charactar);
}

class WelcomeTextState extends State<WelcomeText>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  final String charactar;
  WelcomeTextState(String charactar): this.charactar = charactar;

  initState() {
    super.initState();
    controller = new AnimationController(
      duration: const Duration(seconds: 3), vsync: this
    );

    animation = new Tween(begin: 0.0, end: 30.0).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedText(
      charactar,
      animation: animation,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}