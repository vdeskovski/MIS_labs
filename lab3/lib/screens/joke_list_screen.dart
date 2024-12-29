import 'package:flutter/material.dart';
import 'package:lab3/models/joke_type.dart';
import 'package:lab3/services/api_services.dart';
import 'package:lab3/widgets/joke_list_widget.dart';

import '../models/joke.dart';

class JokeListScreen extends StatefulWidget {
  const JokeListScreen({super.key, required this.jokeType});

  final JokeType jokeType;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _JokeListScreenState();
  }
}

class _JokeListScreenState extends State<JokeListScreen> {
  List<Joke>? jokes;
  String? errorMessage;

  Future<void> _loadJokes() async {
    try {
      List<Joke>? fetchedJokes =
          await ApiService.getJokesByType(widget.jokeType.name);
      setState(() {
        jokes = fetchedJokes;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  @override
  Widget build(BuildContext context) {
    if (jokes == null && errorMessage == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text("Error: $errorMessage")),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jokeType.name),
      ),
      body: JokeListWidget(jokeList: jokes!),
    );
  }
}
