import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _player = '';
  String _bestPlayer = '';

  int _counter = 0;
  int _bestScore = 0;

  bool _isPlaying = false;

  void _onChangedPlayerName(String value) {
    _player = value;
  }

  void _launchGame() async {
    setState(() {
      _counter = 0;
      _isPlaying = true;
      _startTimer();
    });
  }

  void _startTimer() {
    Timer(const Duration(seconds: 5), () {
      _finishGame();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _finishGame() {
    setState(() {
      _isPlaying = false;
      if (_counter > _bestScore) {
        _bestScore = _counter;
        _bestPlayer = _player;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // **************** MENU PART ****************
                if (!_isPlaying)
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                          onChanged: _onChangedPlayerName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your name',
                          ))),

                if (!_isPlaying)
                  if (_bestScore > 0)
                    Text(
                      'Best: $_bestScore - $_bestPlayer',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  else
                    const Text(
                      'Click on the button to start the game',
                    ),
                if (!_isPlaying) const Spacer(),
                if (!_isPlaying)
                  ElevatedButton(
                    onPressed: _launchGame,
                    child: const Text('Play the game!'),
                  ),

                // **************** GAME PART ****************
                if (_isPlaying)
                  Text(
                    'Counter: $_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                if (_isPlaying)
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.plus_one),
                  ),
              ]),
        ),
      ),
    );
  }
}
