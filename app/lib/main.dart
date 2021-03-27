import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'App title here',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
p
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Hello World!')),
      body: Center(child: Text('Template project')),
    ));
  }
}
