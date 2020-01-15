import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'my app', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Widget1(_counter),
          Widget2(),
          Widget3(_increment),
        ],
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  final int counter;

  Widget1(this.counter);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$counter'));
  }
}

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("I'm a Widget that shouldn't be rebuilt");
  }
}

class Widget3 extends StatelessWidget {
  final void Function() incrementCounter;

  Widget3(this.incrementCounter);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: incrementCounter,
      child: Icon(Icons.add),
    );
  }
}
