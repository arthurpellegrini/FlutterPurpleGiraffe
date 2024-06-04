import 'dart:async';

import 'package:flutter/material.dart';

import '../data/game_result.dart';
import 'game_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _gameStarted = false;
  String? _nickname;

  final List<GameResult> _gameResults = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _startGame() {
    setState(() {
      _counter = 0;
      _gameStarted = true;
      Timer(const Duration(seconds: 5), _stopGame);
    });
  }

  void _stopGame() {
    setState(() {
      _gameStarted = false;
      final newGameResult = GameResult(score: _counter, nickname: _nickname);
      _gameResults.add(newGameResult);
      _gameResults.sort((a, b) => b.score.compareTo(a.score));
    });
  }

  void onNicknameChanged(String newNickName) {
    setState(() {
      _nickname = newNickName;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (_gameStarted == false)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: false,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      autofillHints: const [AutofillHints.nickname],
                      onChanged: onNicknameChanged,
                      decoration: const InputDecoration(
                        labelText: "Votre pseudo",
                        helperText:
                            "Sera utilisé pour sauvegarder votre record",
                      ),
                    ),
                  ),
                if (_gameStarted == true)
                  Text(
                    'Clics : $_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                if (_gameStarted == true)
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    label: const Text("ElevatedButton"),
                    icon: const Icon(Icons.plus_one),
                  )
                else
                  Expanded(
                      child: ListView.builder(
                          itemBuilder: _createResultCell,
                          itemCount: _gameResults.length)),
                if (_gameStarted == false)
                  FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GamePage(
                                  receivedValue: "Hello World!",
                                )));
                      },
                      child: const Text("Démarrer la partie")),
              ],
            ),
          ),
        ));
  }

  Widget? _createResultCell(BuildContext context, int index) {
    final gameResult = _gameResults[index];
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                GamePage(receivedValue: gameResult.nickname ?? "Anonyme")));
      },
      title: Text(gameResult.nickname ?? "Anonyme"),
      subtitle: Text("Score : ${gameResult.score}"),
    );
  }
}
