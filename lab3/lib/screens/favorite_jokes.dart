import 'package:flutter/material.dart';
import 'package:lab3/models/joke.dart';
import 'package:lab3/services/firestore_service.dart';
import 'package:lab3/widgets/fav_joke_list_widget.dart';

class FavoriteJokesScreen extends StatefulWidget {
  const FavoriteJokesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteJokesScreenState();
  }
}

class _FavoriteJokesScreenState extends State<FavoriteJokesScreen> {
  List<Joke>? jokeList;

  Future<void> _fetchFavoriteJokes() async {
    try {
      final jokes = await FireStorageService().fetchFavoriteJokes();
      setState(() {
        jokeList = jokes;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchFavoriteJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My favorite jokes"),
      ),
      body: jokeList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : jokeList!.isEmpty
              ? const Center(
                  child: Text("Empty favorite list"),
                )
              : FavoriteJokeListWidget(
                  jokeList: jokeList!, fetchJokes: _fetchFavoriteJokes),
    );
  }
}
