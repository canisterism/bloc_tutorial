import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CountLabel extends StatefulWidget {
  final int favoriteCount;

  CountLabel({
    Key key, // Keyとは ViewModelにおけるインスタンスを一意にするためのkey (レンダリング効率のため)
    @required this.favoriteCount,
  })  : assert(favoriteCount >= 0), // コンストラクタにバリデーションを挟める？
        super(key: key);
  @override
  CountLabelState createState() {
    return CountLabelState();
  }
}

// StatefulWidgetを継承したWidgetをTに持つStateを継承したState
class CountLabelState extends State<CountLabel> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.favoriteCount.toString(), // なぜwidgetがいきなり呼べるのか
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 35.0, color: Colors.pink));
  }
}
