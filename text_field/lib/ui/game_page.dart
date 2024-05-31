import 'dart:async';

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pop(context, _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Game Page'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                  Text(
                    'Counter: $_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.plus_one),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}