import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String receivedValue;
  const GamePage({super.key, required this.receivedValue});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Game Page')),
        body: Center(child: Text(widget.receivedValue)));
  }
}
