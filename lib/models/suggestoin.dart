import 'dart:collection';
import 'package:english_words/english_words.dart';

final Suggestion suggestion = Suggestion(); //何のためにこうしてるのか、これがどう使われるのかさっぱり分からん

class Suggestion {
  final List<WordPair> _suggestedWords = <WordPair>[];

  Suggestion(); // これはホンマに何

  // クラスメソッド？
  Suggestion.clone(Suggestion suggestion) {
    _suggestedWords.addAll(suggestion._suggestedWords); // シンプルに分からん
  }

  // get の宣言必要なのか？
  int get suggestionCount => _suggestedWords.length;

  UnmodifiableListView<WordPair> get suggestedWords =>
      UnmodifiableListView(_suggestedWords);

  void add(WordPair wordPair) {
    _updateCount(wordPair);
  }

  void addMulti(List<WordPair> wordPairs) {
    for (int i = 0; i < wordPairs.length; i++) {
      _updateCount(wordPairs[i]);
    }
  }

  @override
  String toString() => "$suggestedWords";

  void _updateCount(WordPair wordPair) {
    _suggestedWords.add(wordPair);
  }
}
