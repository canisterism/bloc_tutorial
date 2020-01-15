import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'my app',
        home: _HomePage(
          child: Scaffold(
            appBar: AppBar(
              title: Text('my app'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Widget1(),
                Widget2(),
                Widget3(),
              ],
            ),
          ),
        ));
  }
}

class _HomePage extends StatefulWidget {
  _HomePage({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>())
          .data;
    }
    return (context
            .getElementForInheritedWidgetOfExactType<_MyInheritedWidget>()
            .widget as _MyInheritedWidget)
        .data;
  }
}

class _HomePageState extends State<_HomePage> {
  int counter = 0;

  void _increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(child: widget.child, data: this);
  }
}

class Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Widget1 was build');
    final _HomePageState state = _HomePage.of(context);
    return Center(child: Text('${state.counter}'));
  }
}

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Widget2 was build');
    return Text("I'm a Widget that shouldn't be rebuilt");
  }
}

class Widget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Widget3 was build');
    final _HomePageState state = _HomePage.of(context, rebuild: false);
    return FloatingActionButton(
      onPressed: () => state._increment(),
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

class _MyInheritedWidget extends InheritedWidget {
  _MyInheritedWidget({Key key, Widget child, this.data})
      : super(key: key, child: child);

  final _HomePageState data;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
