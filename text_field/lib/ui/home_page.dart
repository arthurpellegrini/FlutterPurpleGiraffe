import 'package:flutter/material.dart';

import '../player_score.dart';
import './game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _playerName = 'Unknown';
  final _playerNameController = TextEditingController();
  final List<PlayerScore> _playerScores = [];

  @override
  void initState() {
    super.initState();
    _playerNameController.text = _playerName;
  }

  @override
  void dispose() {
    _playerNameController.dispose();
    super.dispose();
  }

  void _onChangedPlayerName(String newPlayername) {
    _playerName = newPlayername;
    _playerNameController.text = newPlayername;
  }

  void _launchGame() async {
    final int score = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GamePage()),
    );
    _finishGame(score);
  }

  void _finishGame(int score) {
    setState(() {
      _playerScores.add(PlayerScore(name: _playerName, score: score));
      _playerScores.sort((a, b) => b.score.compareTo(a.score));
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
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                        onChanged: _onChangedPlayerName,
                        controller: _playerNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your name',
                        ))),
                if (_playerScores.isNotEmpty)
                  const Text(
                    'Hall of Fame',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                if (_playerScores.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _playerScores.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: index == 0
                            ? const Icon(Icons.emoji_events, color: Colors.yellow)
                            : index == 1
                                ? const Icon(Icons.emoji_events, color: Colors.grey)
                                : index == 2
                                    ? const Icon(Icons.emoji_events, color: Colors.brown)
                                    : Text('${index + 1}', style: const TextStyle(fontSize: 18)),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _playerScores[index].name,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Score: ${_playerScores[index].score}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                const Spacer(),
                SizedBox(
                  width: 200, // Définir la largeur
                  height: 75, // Définir la hauteur
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Ajouter de l'espace autour du bouton
                    child: FilledButton(
                      onPressed: _launchGame,
                      child: const Text('Launch Game'),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
