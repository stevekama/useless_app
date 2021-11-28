import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class InfoApp extends StatefulWidget {
  const InfoApp({Key? key}) : super(key: key);
  InfoAppState createState() => InfoAppState();
}

class InfoAppState extends State<InfoApp> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, item) {
          if (item.isOdd) return Divider();

          final index = item ~/ 2;

          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red[600] : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 16.0),
          ),
        );
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
          appBar: AppBar(title: Text('Saved WordPairs', style: TextStyle(fontSize: 20.0),)),
          body: ListView(children: divided));
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Word pair Generator',
        ),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list)),
        ],
      ),
      body: Center(
        child: _buildList(),
      ),
    );
  }
}