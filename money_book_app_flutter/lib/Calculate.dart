import 'package:flutter/material.dart';
import "package:intl/intl.dart";
class Calculate extends StatefulWidget {

  // コンストラクタ
  Calculate({Key key, this.currentDate}) : super(key: key);

  // CalenderウィジットからcurrentDateを受け取る
  // メンバ変数の宣言（クラスのスコープで使える変数の宣言）
  final DateTime currentDate;

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {

  // 検証用（削除する）
  List testList = ['a','b','c'];
  List<Map<String, String>> testMapList = [{}];



  // 取得した年月日
  String currentDateStr;
  // 項目名を取得
  TextEditingController _itemController = new TextEditingController();
  // 金額を取得
  TextEditingController _moneyController = new TextEditingController();
  // インデックスを取得
  TextEditingController _indexController = new TextEditingController();

  // controllerで取得した項目名と金額を入れる
  String text;
  String _itemText = '';
  String _moneyText = '';
  int _index;

  // 家計簿リスト
  List<Map<String,String>> houseMoneyList = [];

  // 家計簿リストから繰り返し処理で配列を作成する
  Map<String,String> moneyList ={};

  // 家計簿リストから繰り返し処理で配列を作成する
  // Map<int, Map<String,String>> listChangeMap ={};

  Map<int ,Map<String,String>> listChangeMap ={};
  List<int> indexList =[];

  // moneyListを作成して、houseMoneyListにaddしていく
  @override
  void initState(){
    super.initState();
  // DateFormatクラスでformatterを作成する
    DateFormat formatter = new DateFormat('yyyy/MM/dd(E)', "ja_JP");
  // currentDateStrを初期化する
    currentDateStr = formatter.format(widget.currentDate);

    // 初期化<String,String>
    moneyList =  {
      'item':_itemText,
      'money':_moneyText,
    };

    // testMapList = [{'test':'aaa'},{'test':'bbb'},{'test':'ccc'}];
    // houseMoneyListのindexを取得して、map型にする
    // map型からindexのみを抜き出して、listChangeMapに入れる  listChangeMap[0,1,2...]
    listChangeMap = houseMoneyList.asMap();
    //  print('Index: $i' + ' Value: $value')});
  }

  // indexを取得する
  // Map<String, String>listChangeMap = houseMoneyList.asMap();

  //  itemView関数
  Widget itemView(value,index){
    print(value);
    print(index);
    // print(value); //valueには{項目:食費,金額:1888}が入っている
    // print(value['item']); //value['item']には'食費'が入っている
    return Container(
      child: Column(
        children: [
          Text(value['item']),
          Text(value['money']),
          RaisedButton(
            child: const Text('削除'),
            color: Colors.pink,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
            ),
            onPressed: () => {
              _index = index,
              houseMoneyList.removeAt(indexList[_index]),
              // print(_index),
              // print(indexList)
            }
          ),
          RaisedButton(
            child: const Text('編集'),
            color: Colors.yellow,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
            ),
            onPressed: (){}
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:
        Container(
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
            ),
            // 入力値を反映する
            RaisedButton(
              child: const Text('入力'),
              color: Colors.green,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              // 項目と金額を取得する
              onPressed: () =>setState(()=>{
                _itemText = _itemController.text,
                _moneyText = _moneyController.text,
                // ここで取得したitemTextとmoneyTextの値を,moneyListの中に入れる
                moneyList = {'item':_itemText,'money':_moneyText},
                houseMoneyList.add(moneyList), 
                listChangeMap.forEach((index,value)=>indexList.add(index)),
                // リストのインデックスの配列を作成する
                //入力を押したら,indexListに入っている
                print(houseMoneyList),
                print(indexList)
              }),),
              // カレンダーで取得した日付を反映する
            Text(currentDateStr),
            ListView(
              shrinkWrap: true,
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[ 
                        for(int i = 0; i < houseMoneyList.length; i++)
                          // 呼び出し先に渡す
                          itemView(houseMoneyList[i],indexList[i]),
                        //i番目のmoneyList{String,String}が入る
                      ],
                    )
                  )
                ]      
            ),
            RaisedButton(
              child: const Text('支出合計'),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              onPressed: ()=>{},
            ),
            // 前の画面に戻る
            RaisedButton(
              child: const Text('戻る'),
              color: Colors.purple,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              onPressed: ()=>Navigator.pop(context),
            ),
          ]
        ),
       )
      )
    );
  }
}
