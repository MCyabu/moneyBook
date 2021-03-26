import 'package:flutter/material.dart';

class Calculate extends StatefulWidget {
  Calculate({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 日付、支出項目、金額を入力する欄
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(labelText: '日付'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '項目'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '金額'),
          ),
          RaisedButton(
            child: const Text('入力'),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {},),
          Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text('日付'),
                Text('項目'),
                Text('金額'),
              ],
            )
          )
        ],)
      )
    );
  }
}
