import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class Calculate extends StatefulWidget {
  // コンストラクタ
  Calculate({
    Key key,
    this.currentDate,
    this.dataList,
    this.curHouseMoneyList,
  }) : super(key: key);

  // CalenderウィジットからcurrentDateを受け取る
  // メンバ変数の宣言（クラスのスコープで使える変数の宣言）
  // メンバ変数（フィールド）はクラス内のメソッドから参照可能な変数
  final DateTime currentDate;
  final Map<DateTime, List<Map<String, String>>> dataList;
  final List<Map<String, String>> curHouseMoneyList;

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  // 取得した年月日
  String currentDateStr;
  // 項目名を取得
  TextEditingController _itemController = new TextEditingController();
  // 金額を取得
  TextEditingController _moneyController = new TextEditingController();

  // controllerで取得した項目名と金額を入れる
  String text;
  String _itemText = '';
  String _moneyText = '';

  // 編集用に取得するindex
  int editIndex;

  // 編集中かどうかの判断
  bool editflag;

  // 家計簿リストの金額の合計値
  String strSum = '';

  // 家計簿リスト
  List<Map<String, String>> houseMoneyList = [];

  // 家計簿リストから繰り返し処理で配列を作成する
  Map<String, String> moneyList = {};

  // Map<DateTime, List<Map<String, String>>> tempDateList = {};

  // moneyListを作成して、houseMoneyListにaddしていく
  @override
  void initState() {
    super.initState();
    // DateFormatクラスでformatterを作成する
    DateFormat formatter = new DateFormat('yyyy/MM/dd(E)', "ja_JP");
    // currentDateStrを初期化する
    currentDateStr = formatter.format(widget.currentDate);

    // houseMoneyListを初期化
    houseMoneyList = widget.curHouseMoneyList;
    print(widget.curHouseMoneyList);
  }

  void newItem() {
    setState(() => {
          _itemText = _itemController.text,
          _moneyText = _moneyController.text,
          // itemTextとmoneyTextの値を,moneyListの中に入れる
          moneyList = {'item': _itemText, 'money': _moneyText},
          if (editflag != true)
            {
              // houseMoneyListにない場合
              houseMoneyList.add(moneyList),
              // 文字列を数値に変換
            }
          else
            {
              print('hoge'),
              houseMoneyList[editIndex] = moneyList,
              // int.parse(moneyList['money']),
              editflag = false
            },
          sumMoney()
        });
  }

  void sumMoney() {
    List numList = [];
    int sum = 0;
    setState(() => {
          for (int i = 0; i < houseMoneyList.length; i++)
            {
              // numList.add(int.parse(houseMoneyList[i]['money']))
              sum += int.parse(houseMoneyList[i]['money'])
            },
          // sum = numList.reduce((value, element) => value + element),
          strSum = sum.toString(),
          print(numList),
          print(sum),
        });
  }

  //  itemView関数
  Widget itemView(value, index) {
    return Container(
        child: Column(children: [
      Text(value['item']),
      Text(value['money']),
      RaisedButton(
        child: const Text('削除'),
        color: Colors.pink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () => setState(() => {
              houseMoneyList.removeAt(index),
              sumMoney(),
            }),
      ),
      RaisedButton(
          child: const Text('編集'),
          color: Colors.yellow,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            _itemController.text = value['item'];
            _moneyController.text = value['money'];
            editflag = true;
            editIndex = index;
          })
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
            child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              //項目の入力を受けとる
              controller: _itemController,
              decoration: InputDecoration(labelText: '項目'),
            ),
            TextFormField(
              // 金額の入力を受け取る
              controller: _moneyController,
              decoration: InputDecoration(labelText: '金額'),
              keyboardType: TextInputType.number,
            ),
            // 入力値を反映する
            RaisedButton(
                child: const Text('入力'),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // 項目と金額を取得する
                onPressed: () => {newItem()}),
            // カレンダーで取得した日付を反映する
            Text(currentDateStr),
            ListView(shrinkWrap: true, children: [
              Container(
                  child: Column(
                children: <Widget>[
                  for (int index = 0; index < houseMoneyList.length; index++)
                    // 呼び先に渡す
                    itemView(houseMoneyList[index], index),
                ],
              ))
            ]),
            Text(strSum),
            // 前の画面に戻る
            RaisedButton(
              child: const Text('保存'),
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // 遷移元に返す値 配列houseMoneyList
              onPressed: () => Navigator.pop(context, houseMoneyList),
            ),
          ]),
        )));
  }
}
