import 'package:flutter/material.dart';
import 'package:bloc_tutorial/models/word.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage(this.word);
  final Word word;

  static const routeName = "/favorite";

  @override
  Widget build(BuildContext context) {
    final tiles = word.items.map((item) {
      return ListTile(title: Text(item.name));
    });

    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return Scaffold(
        appBar: AppBar(title: Text("Your Favorite")),
        body: ListView(children: divided));
  }
}
