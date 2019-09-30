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
  AnimatedText(this.charactar, {Key key, Animation<double> animation, Animation<double> curve})
      : super(key: key, listenable: curve);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    // final String charactar = 'LL';
    return new Center(
      child: Transform.translate(
        offset: Offset(0, animation.value),
        child: Text(
          this.charactar,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            height: 1.2,
            decoration: TextDecoration.none,
          )
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
  Animation<double> animation;
  Animation<double> curve;
  AnimationController controller;

  final String charactar;
  WelcomeTextState(String charactar) : this.charactar = charactar;

  initState() {
    super.initState();
    // controller = new AnimationController(
        // duration: const Duration(seconds: 3), vsync: this);

    // controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    // CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    
    // animation = new Tween(begin: 0.0, end: 30.0).animate(controller);
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 60.0).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     //动画执行结束时反向执行动画
    //     controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     //动画恢复到初始状态时执行动画（正向）
    //     controller.forward();
    //   }
    // });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedText(
      charactar,
      animation: animation,
      curve: curve,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
