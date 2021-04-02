// import 'dart:html';
import 'package:flutter/material.dart';
import 'Calculate.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import "package:intl/intl.dart";

class Calender extends StatefulWidget {

  Calender({Key key, this.title}) : super(key: key);

  // フィールド変数
  final String title;

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  Map<DateTime, List<Map<String, String>>> dataList = {};

  DateTime firstDay;  //範囲指定の最初の日付 （初期値は現在日、変更したら変更後の日付）
  String strFirstDay; //firstDayを文字列に変換

  DateTime lastDay; //範囲指定の最後の日付 （初期値は現在日、変更したら変更後の日付）
  String strLastDay; //lastDayを文字列に変換

  String sumMoneyOfRangeDays; //範囲指定した日付にある金額を合計

  @override
  void initState() {
    super.initState();

    firstDay = DateTime.now();
    lastDay = DateTime.now();

    strFirstDay = '';
    strLastDay = '';

    sumMoneyOfRangeDays = '';
  }
  
  // 最初の日付指定用のカレンダー
   Future<Null> _selectFirstDate(BuildContext context) async {
    
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: firstDay,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360))
    );
    // pickedには選択した日付が入っている
    if(picked != null) {
      setState((){
        firstDay = picked;
        // 日付をString型に変換して
        DateFormat formatter = new DateFormat('yyyy/MM/dd(E)', "ja_JP");
        strFirstDay = formatter.format(firstDay);
      });
    }
  }

  // 最後の日付指定用のカレンダー
   Future<Null> _selectLastDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: lastDay,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360))
    );
    // pickedには選択した日付が入っている
    if(picked != null) {
      setState((){
        lastDay = picked;
        // 日付をString型に変換
        DateFormat formatter = new DateFormat('yyyy/MM/dd(E)', "ja_JP");
        strLastDay = formatter.format(lastDay);
        }
      );
    }
  }

  void getSumMoneyOfRangeDays(){
    int differenceInDays = lastDay.difference(firstDay).inDays;
    int sumMoney = 0;
    // print(dataList);
    for(int i = 0; i < differenceInDays+1 ; i++){
      // 最初の日付に、1日ずつ足していく
      DateTime oneDayAfterFirstDay = firstDay.add(Duration(days:i));
      // dataListに、上記の日付がMapのkeyに含まれている場合
      if(dataList.containsKey(oneDayAfterFirstDay) == true ){
        for(int v = 0; v < dataList[oneDayAfterFirstDay].length; v++){
        // Stringからintに変換する
        int templateSumMoney = int.parse(dataList[oneDayAfterFirstDay][v]['money']);
        sumMoney += templateSumMoney;
        } 
      // Stringに変換する
      }
    }
    setState(()=>sumMoneyOfRangeDays = sumMoney.toString());
    print(sumMoneyOfRangeDays);
  }
  // 表示
  @override
  Widget build(BuildContext context) {

    // DateTime oneDayAfterFirstDay; // 翌日の日付。１日ずつ追加していく。
    
    return Scaffold(body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Card(
                // カレンダー表示
                child: CalendarCarousel<Event>(
                  height: 420.0,
                    // onDayPressed 日付を押したときの挙動
                    onDayPressed: (DateTime date, List<Event> events) async {
                      // dataListに選択した日付の情報がないとき、初期値として空の配列を入れたい
                      if (dataList.containsKey(date) == false) {
                        dataList[date] = [];
                      }
                      List result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new Calculate(
                                  currentDate: date,
                                  curHouseMoneyList: dataList[date],
                                )),
                      );
                      // dataListには、各日付で取得した項目と金額が入っている
                      setState(() {
                        dataList[date] = result;
                      });
                    })
              ),
              Row(
                children: [
                  // 範囲指定で最初の日付
                  Expanded(
                    child: Container(
                      child:RaisedButton(
                        child: const Text('開始'),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: ()=>{_selectFirstDate(context),
                        print(firstDay)
                        })
                    ),
                  ),
                  // 範囲指定で最後の日付
                  Expanded(
                    child: Container(
                      child:RaisedButton(
                        child: const Text('終了'),
                        color: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: ()=>{_selectLastDate(context),print(lastDay)})
                    ),
                  ),
                  // 取得した範囲の日付で金額を合計する
                  Expanded(
                    child: Container(
                      child:RaisedButton(
                        child: const Text('合計'),
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: ()=>{getSumMoneyOfRangeDays()}
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(strFirstDay)
                    )
                  ),
                  Expanded(
                    child: Container(
                      child: Text(strLastDay)
                    )
                  ),
                  Expanded(
                    child: Container(
                      child: Text(sumMoneyOfRangeDays)
                    )
                  ),
                ]
              )
            ]
          )
    )
    );
  }
}
