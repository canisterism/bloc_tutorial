import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'my app', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  final CounterRepository repository = CounterRepository();

  // static _MyHomePageState of(BuildContext context, {bool rebuild = true}) {
  //   if (rebuild) {
  //     return context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>().data;
  //   }
  // }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isLoading = false;

  void _increment() async {
    setState(() {
      _isLoading = true;
    });
    await widget.repository.fetch().then((increaseCount) {
      setState(() {
        _counter += increaseCount;
      });
    }).whenComplete(
      () => setState(
        () {
          _isLoading = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
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
      ),
      LoadingWidget(_isLoading)
    ]);
  }
}

class Widget1 extends StatelessWidget {
  final int counter;

  Widget1(this.counter);

  @override
  Widget build(BuildContext context) {
    print('Widget1 was build');
    final _MyHomePageState state = _MyHomePage.of(context);
    return Center(child: Text('$state.counter'));
  }
}

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("I'm a Widget that shouldn't be rebuilt");
  }
}

class Widget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _MyHomePageState state = MyHomePage.of(context, rebuild: false);
    return FloatingActionButton(
      onPressed: state._increment(),
      child: Icon(Icons.add),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  LoadingWidget(this.isLoading);
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const DecoratedBox(
            decoration: BoxDecoration(color: Color(0x44000000)),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox.shrink();
  }
}

class CounterRepository {
  Future<int> fetch() {
    return Future<int>.delayed(const Duration(seconds: 1)).then((_) {
      return 1;
    });
  }
}
