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
  String _playername = '';
  String _bestPlayername = '';

  int _score = 0;
  int _bestScore = 0;

  bool _isPlaying = false;

  void _onChangedPlayerName(String newPlayername) {
    _playername = newPlayername;
  }

  void _launchGame() async {
    setState(() {
      _score = 0;
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
      _score++;
    });
  }

  void _finishGame() {
    setState(() {
      _isPlaying = false;
      if (_score > _bestScore) {
        _bestScore = _score;
        _bestPlayername = _playername;
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
                      'Best: $_bestScore - $_bestPlayername',
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
                    'Counter: $_score',
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
