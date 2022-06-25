import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main(){
  //ここがスタート
  runApp(MaterialApp(
    home: TimeSamplePage()
  ));
}

//状態を持てるのはSTFだけ
class TimeSamplePage extends StatefulWidget {
  const TimeSamplePage({Key? key}) : super(key: key);

  @override
  State<TimeSamplePage> createState() => _TimeSamplePageState();
}


class _TimeSamplePageState extends State<TimeSamplePage> {
  late Timer _timer; //状態
  late DateTime _time; //ここで時間の形になっている
  bool isVisible = true;
  bool isVis = false;

  @override
  void initState() { //初期化処理
    // TODO: implement initState
    _time = DateTime.utc(0,0,0);
    super.initState();
  }

//initStateが実行された後に、buildを実行して描画される
//その後はsetState()が呼ばれるたびbuild()を実行して UI に変更を反映します

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.timer),
        title: Text('5秒で止めちゃって〜〜!!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: NetworkImage('https://spice.eplus.jp/images/GH5GLO3GwHB29kAZA5W4AsLfUKEMRZeL6zGdoiVrOsldNAysgqNPSaAtw52X2t9r',),),
          Visibility(
            visible: isVisible, //表示状態
            // maintainSize: true,
            child: Text(
              //その時点での時間（_time）を00:00:00形式で表示している
              DateFormat.Hms().format(_time),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Visibility(
            visible: isVis,
            child: (_time == DateTime.utc(0,0,05))?Text(
              'どんだけ〜!!',
              style: Theme.of(context).textTheme.headline2,
              )
              :Text(
                'いかほど〜！',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: (){  //ストップボタンタップ時
                //isVisible = !isVisible;  //表示
                if(_timer != null && _timer.isActive)
                _timer.cancel();
                setState(() {
                  isVisible = !isVisible;  //表示
                  isVis = !isVis;
                });
                
                },
                child: Text('Stop'),
              ),
              SizedBox(width: 16,),
              FloatingActionButton(
                onPressed: (){
                  isVisible = !isVisible; //非表示
                  //一秒ごとに定期的に処理を実行
                  _timer = Timer.periodic(
                    Duration(seconds: 1),
                    (Timer timer) {
                      //_timeに一秒追加する関数
                      setState(() {
                        _time = _time.add(Duration(seconds: 1));
                      });
                    },
                  );
                },
                child: Text('Start'),
              ),
            ],
          ),
        ],
      ),
    );
    
  }
}