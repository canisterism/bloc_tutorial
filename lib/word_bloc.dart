import 'dart:async';
import 'package:bloc_tutorial/models/word.dart';
import 'package:bloc_tutorial/models/word_item.dart';
import 'package:rxdart/subjects.dart';

class WordAddition {
  final String name;
  WordAddition(this.name);
}

class WordRemoval {
  final String name;
  WordRemoval(this.name);
}

class WordBloc {
  final Word _word = Word();

  // これらのBehaviorSubjectはFavorite辺りのWidgetからlisten()される(はず)
  // Favoriteに対してpublishする値は以下のStreamControllerから受け取った値をそのまま流す
  final BehaviorSubject<List<WordItem>> _items =
      BehaviorSubject<List<WordItem>>.seeded([]);

  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);

  // このStreamControllerはHomeのからpublishされるSinkを待つ(?)
  // その値は_items.add でBehaviorSubjectにそのままSinkとして渡す
  final StreamController<WordAddition> _wordAdditionController =
      StreamController<WordAddition>();

  final StreamController<WordRemoval> _wordRemovalController =
      StreamController<WordRemoval>();

  WordBloc() {
    _wordAdditionController.stream.listen((addition) {
      int currentCount = _word.itemCount;
      _word.add(addition.name); // List.add()
      _items.add(_word.items); // BehaviorSubject.add()
      int updateCount = _word.itemCount;
      if (updateCount != currentCount) {
        _itemCount.add(updateCount);
      }
    });

    _wordRemovalController.stream.listen((removal) {
      int currentCount = _word.itemCount;
      _word.remove(removal.name);
      print(_word.items.toString());
      _items.add(_word.items);
      int updateCount = _word.itemCount;
      if (updateCount != currentCount) {
        _itemCount.add(updateCount);
      }
    });
  }

  Sink<WordAddition> get wordAddition => _wordAdditionController.sink;
  Sink<WordRemoval> get wordRemoval => _wordRemovalController.sink;

  Stream<int> get itemCount => _itemCount.stream;
  Stream<List<WordItem>> get items => _items.stream;

  void dispose() {
    _items.close();
    _itemCount.close();
    _wordAdditionController.close();
    _wordRemovalController.close();
  }
}
