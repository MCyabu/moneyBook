import 'package:flutter/material.dart';

class Calender extends StatefulWidget {
  Calender({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
            body: Container(
              height: 500,
              width: 500,
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child:
                Text(
                    '認証中',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontSize:
                            Theme.of(context).textTheme.headline6.fontSize),
                ))
      );
    }
  }

