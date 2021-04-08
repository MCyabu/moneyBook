
// import 'dart:html';

import 'package:flutter/material.dart';
import 'Calculate.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import "package:intl/intl.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// shared preferenceが使用できるか
// 

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

  // データの保存
  Future _saveFile(BuildContext context) async {
   SharedPreferences prefs = await SharedPreferences.getInstance(); 
    for( DateTime key in dataList.keys) { 
      String saveList = jsonEncode(dataList[key]);
      // String saveList = jsonDecode(saveList);
      // prefs.setString(key.toString(), saveList);
      prefs.setString(key.toString(), saveList);
    }
  }

  // データの読み込み
   Future _readFile(BuildContext context) async {
   SharedPreferences prefs = await SharedPreferences.getInstance(); 
   print(prefs);
    setState(() {
      for( String key in prefs.getKeys()) { //保存しているデータのKeyを、変数keyに入れて、forin文で回す
        //保存したデータのkeyをdecodeして、DateTime型にする  //2021-04-05 00:00:00.000
        DateTime tempDataKeys = DateTime.parse(jsonDecode(jsonEncode(key))); 
        // 保存したデータをデコードする // [{item: 食費, money: 555}]
        final List<dynamic> tempValueList =jsonDecode(prefs.getString(key.toString()));


        // dataList[tempDataKeys] = [{'aaa':'ccc'}]; //OK
        // 
        // dataList[tempDataKeys] = tempValueList; //type 'List<dynamic>' is not a subtype of type 'List<Map<String, String>>'
        // // // 
        //  List<Map<String, String>> sample = [tempValueList[0].cast<String, String>()]; 
        // dataList[tempDataKeys] = sample;
        // 日付ごとのリストを作る
        // List<Map<String, String>>のvalueを作る
        // 2つ合った場合、2つはいったリスト
        // dataListのvalueに代入するリストを宣言する(sampleList)
        List<Map<String, String>> sampleList = [] ;
        // --->tempValueList を繰り返し処理で変数--->sampleListに入れる
        for(int i = 0; i < tempValueList.length; i ++){
          sampleList.add(tempValueList[i].cast<String, String>());
          print('出力');
          print(sampleList);
        }
        // dataListにtempDataKeysと、sampleListを入れる ---> dataList[temp...]=sampleList
        dataList[tempDataKeys] = sampleList;
        print(dataList);
        // これを繰り返す（forin）
          
          // dataList[tempDataKeys] = [tempValueList[i].cast<String, String>()]; //要素が2個の場合、上書きされる

     
        
        // type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'Map<String, String>' in type cast
        // 
        // final  tempValueList = <Map<String,String>>[jsonDecode(prefs.getString(key.toString()))];
        // tempValueList.cast<Map<String, String>>();
        // // (type 'List<dynamic>' is not a subtype of type 'Map<String, String>')
        
        // print(dataList);

        
        // final sample =  <String,dynamic>{'aaa': 123};
        // sample.cast<String, String>();
        // print(sample);
        // 
        // List<Map<String, String>>.from(tempValueList);
        // _TypeError (type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'Map<String, String>')

        // List<Map<String, String>>sample = tempValueList.cast<Map<String, String>>();  
        
        // _CastError (type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'Map<String, String>' in type cast)//
        // print(tempValueList);

        // dataList[tempDataKeys] = tempValueList; //type 'List<dynamic>' is not a subtype of type 'List<Map<String, String>>'
        
        // print(dataList[tempDataKeys]);

      //  print(a);

        // print(dataList[tempDataKeys]); 

      //   // 一度sampleListを作って、変換して代入を試す
      //  List<dynamic> sampleList = [{'item': '食費', 'money': '555'}];
      //   Map<DateTime, List<Map<String, String>>> sample = sampleList.cast<List<DateTime, List<Map<String, String>>>>();
      //   print(sampleList);
        // Map型に追加するのは
        // 変数名[key] = value
        // これでしようとすると、List<dynamic>はList<Map<String, String>>じゃないというエラーがでる
        // dataList[tempDataKeys]= tempValueList;
        // tempValueListからMap型をとりだして、dataListのvalueにいれればよいのでは
        // tempValueListに入っているMap型はMap<String,dynamic>なので、できませんよというエラーが出る
        // じゃあこのMap<String,dynamic>を、Map<String,String>にしないといけない
        // castで変換できるのは。
        // List<dynamic>
        // List<Map<String, String>>

        // tempValueList.cast<Map<String, String>>();//できなかった
          // dataList[tempDataKeys][0]= new Map<String,String>.from(tempValueList[0]);
        //  Map<String,List<Map<String,String>>> sample = {'ccc':[{'aaa':'bbb'},{'eee':'rrr'}]};
        //  sample['ccc'][1] = {'aaa':'bbb'};
        //   print(sample);
          // dataList[tempDataKeys][0]= tempValueList[0].cast<Map<String, String>>();
          // print(prefs.getString(key.toString()));  // "[{"item":"食費","money":"555"}]"
          // print(jsonDecode(prefs.getString(key.toString())));  // [{item: 食費, money: 555}]
          // print(tempValueList[0]); // {item: 食費, money: 555}
          // print(tempDataKeys);  //2021-04-05 00:00:00.000
          // print(dataList); // {}
          // print(dataList[tempDataKeys]);  //
          // print(dataList);
        }
      });
    }
  
  // データを全削除
   Future _removeFile(BuildContext context) async {
   SharedPreferences prefs = await SharedPreferences.getInstance(); 
    setState(() {
      for( String key in prefs.getKeys()) {
        prefs.remove(key);   
        }
      });
    }


  // 最初の日付指定用のカレンダー
   Future<Null> _selectFirstDate(BuildContext context) async {

    //最初の日付を保存
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
        // _strFirstDay = prefs.getString(strFirstDay); 
       }
      );
    }
  }

  // 最後の日付指定用のカレンダー
   Future<Null> _selectLastDate(BuildContext context) async {
    // 最後の日付を保存
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

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

// 日付を範囲指定して、合計金額を出す
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
      }
    }
    setState(()=>sumMoneyOfRangeDays = sumMoney.toString());
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
                      // if (dataList.containsKey(date) == false) {  //dataList基準
                      if (dataList.containsKey(date) == false) {  //saveDate基準
                        dataList[date] = [];
                      }
                      // 日付を押した時に、中にデータが入っていたら、それを表示する
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
              Column (children: [
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
                          onPressed: ()=>{_selectLastDate(context),
                          })
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
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child:RaisedButton(
                          child: const Text('データ保存'),
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: ()=>_saveFile(context)
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child:RaisedButton(
                          child: const Text('データ読み込み'),
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: ()=>_readFile(context)
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child:RaisedButton(
                          child: const Text('データ消去'),
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: ()=>_removeFile(context)
                        )
                      ),
                    ),
                  ] 
                )
              ],)
            ]
          )
    )
    );
  }
}
