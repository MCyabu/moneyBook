import 'package:flutter/material.dart';
import 'Calculate.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel; 

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
        // カレンダー表示
        child: CalendarCarousel<Event>(  
          // onDayPressed 日付を押したときの挙動
           onDayPressed: (DateTime date, List<Event> events){
             DateTime currentTime = new DateTime.now();
             print(currentTime);

          // 日付押すと、別ページに飛ぶ
            Navigator.push(context, MaterialPageRoute(builder: (context) => Calculate())
            );
          }

          // 別ページには、日付、項目名、金額入力欄、入力ボタンがある
          // 日付には、カレンダーで押した日付を出す
          // 入力ボタンを押すと、画面下に、リストが出る
          // １日の合計金額がでる

        )
      )
    );
  }
}

