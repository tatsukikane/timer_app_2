import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main(){
  runApp(MaterialApp(
    home: TimeSamplePage()
  ));
}

class TimeSamplePage extends StatefulWidget {
  const TimeSamplePage({Key? key}) : super(key: key);

  @override
  State<TimeSamplePage> createState() => _TimeSamplePageState();
}


class _TimeSamplePageState extends State<TimeSamplePage> {
  late Timer _timer; //状態
  late DateTime _time; //ここで時間の形になっている

  @override
  void initState() { //初期化処理
    // TODO: implement initState
    _time = DateTime.utc(0,0,0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.Hms().format(_time),
            style: Theme.of(context).textTheme.headline2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: (){  //ストップボタンタップ時
                  if(_timer != null && _timer.isActive)
                  _timer.cancel();
                },
                child: Text('Stop'),
              ),
              FloatingActionButton(
                onPressed: (){
                  _timer = Timer.periodic(
                    Duration(seconds: 1),
                    (Timer timer) {
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