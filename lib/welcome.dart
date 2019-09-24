import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Listify',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22.0,
              height: 1.2,
              decoration: TextDecoration.none,
            )
          ),
        ],
      ),
    );
  }
}
