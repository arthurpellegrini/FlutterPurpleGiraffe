import 'dart:convert';

import 'package:clicker_esiee/data/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String? _error;
  List<User>? _users;
  bool _isLoading = false;
  Future<List<User>> _loadUserList() async {
    await Future.delayed(const Duration(seconds: 2));
    final url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(url);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      setState(() {
        _error = 'Erreur lors du chargement des données';
      });
      return [];
    } else {
      final downloadedUserList = <User>[];
      final decodedUserList = jsonDecode(response.body) as List;
      for (final userJson in decodedUserList) {
        final user = User.fromJson(userJson as Map<String, dynamic>);
        downloadedUserList.add(user);
      }
      return downloadedUserList;
    }
  }

  Future<void> onButtonTouched() async {
    setState(() {
      _isLoading = true;
    });
    final downloadedContent = await _loadUserList();
    setState(() {
      _users = downloadedContent;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userList = _users;
    final error = _error;
    return Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (_isLoading)
                const CircularProgressIndicator.adaptive()
              else if (userList != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: Text(user.website),
                      );
                    },
                  ),
                )
              else if (error != null)
                Text(error),
              ElevatedButton(
                onPressed: onButtonTouched,
                child: const Text('Charger la liste des utilisateurs'),
              ),
            ],
          ),
        ));
  }
}
