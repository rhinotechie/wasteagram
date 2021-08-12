import 'package:flutter/material.dart';
import 'package:wasteagram/screens/post_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(brightness: Brightness.dark),
      home: PostScreen(),
    );
  }
}
