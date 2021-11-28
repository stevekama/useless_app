import 'package:flutter/material.dart';
import 'random/words.dart';

void main() => runApp(UselessApp());

class UselessApp extends StatelessWidget {
  const UselessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: InfoApp());
  }
}
