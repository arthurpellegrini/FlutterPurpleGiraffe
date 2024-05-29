import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Clicker Game'),
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
  int _bestScore = 0;

  void _launchGame() async {
    final int result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyGamePage(title: "Game In Progress")),
    );
    setState(() {
      if (result > _bestScore) {
        _bestScore = result;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Best Score: $_bestScore',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _launchGame,
              child: const Text('Play the game!'),
            ),
            
          ],
        ),
      ),
    );
  }
}

class MyGamePage extends StatefulWidget {
  const MyGamePage({super.key, required this.title});

  final String title;

  @override
  State<MyGamePage> createState() => _MyGamePageState();
}

class _MyGamePageState extends State<MyGamePage> {
  int _counter = 0;
  Timer? _timer;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 20), () {
      Navigator.pop(context, _counter);
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nombre de clics: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Icon(Icons.plus_one),
            ),
          ],
        ),
      ),
      
    );
  }
}
