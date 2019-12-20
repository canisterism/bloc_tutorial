import 'package:flutter/widgets.dart';
import 'package:bloc_tutorial/word_bloc.dart';

class WordProvider extends InheritedWidget {
  final WordBloc wordBloc;

  WordProvider({
    Key key,
    WordBloc wordBloc,
    Widget child,
  }) : wordBloc = wordBloc ?? WordBloc(),
       super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // なにこれ of とは staticとは dependOnInheritedWidgetOfExactTypeとは
  static WordBloc of(BuildContext context) =>
    (context.dependOnInheritedWidgetOfExactType(WordProvider) as WordProvider).wordBloc
}
