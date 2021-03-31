import 'package:flutter/material.dart';
import 'Calculate.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class Calender extends StatefulWidget {
  // コンストラクタ
  // ここに、画面遷移時に渡された値が入る
  // this.フィールド名の引数で、フィールドに値を代入できる。
  // thisを省略すると、別の仮引数として扱われてしまう
  Calender({Key key, this.title}) : super(key: key);

  // フィールド
  final String title;

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  Map<DateTime, List<Map<String, String>>> dataList = {};
// 2021-03-23 'item':'食費'
// 2021-03-24 'item':'日用品'
// 関数を作成して、引数にdateを入れる
// dateを検索する
// 見つけたdateが同じ日であれば、呼び元にそのMapを返す
// 呼び元がそのデータを、次のページに渡す。

  @override
// ここで初期化したら、参照どころではない
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        // カレンダー表示
        child: CalendarCarousel<Event>(
            // onDayPressed 日付を押したときの挙動
            onDayPressed: (DateTime date, List<Event> events) async {
      // 追加する
      // dataListに選択した日付の情報がないとき、初期値として空の配列を入れたい
      if (dataList.containsKey(date) == false) {
        dataList[date] = [];
      }
      // dataList = {'3/12':[{'item':'項目',}],'3/13':[{'item':'項目'}]};

      // dataList
      // {2021/03/21 00:00:00.000:[{'item':'食費','money':'1000'}],
      // 2021/03/22 00:00:00.000:[{'item':'日用品','money':'500'}],
      // 2021/03/23 00:00:00.000:[{'item':'飲料水','money':'990'}]}

      // houseMoneyList
      // [{item: 食費, money: 1000},{item: 食費, money: 1000},{item: 食費, money: 1000},]

      // 日付押すと、別ページに飛ぶ
      List result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new Calculate(
                  currentDate: date,
                  curHouseMoneyList: dataList[date],
                )),
      );
      setState(() {
        dataList[date] = result;
      });
      // print(dataList);
      // print(result[0]['item']); //[{}]が入っている
    })));
  }
}
