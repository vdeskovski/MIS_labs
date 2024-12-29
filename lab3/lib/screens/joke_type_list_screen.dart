import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lab3/models/joke_type.dart';
import 'package:lab3/screens/favorite_jokes.dart';
import 'package:lab3/screens/random_joke_screen.dart';
import 'package:lab3/services/api_services.dart';
import 'package:lab3/services/auth_service.dart';
import 'package:lab3/widgets/joke_type_list_widget.dart';

import '../main.dart';
import '../models/joke.dart';
import '../services/notification_services.dart';
import 'joke_list_screen.dart';

class JokeTypeListScreen extends StatefulWidget {
  JokeTypeListScreen({super.key});

  //List<JokeType> jokeTypes = ApiService.getJokeTypes() as List<JokeType>;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _JokeTypeListScreenState();
  }
}

class _JokeTypeListScreenState extends State<JokeTypeListScreen> {
  List<JokeType>? jokeTypes;
  Joke? randomJoke;
  String? errorMessage;
  String? errorRandomJokeMessage;

  Future<void> _loadJokeTypes() async {
    try {
      List<JokeType> fetchedJokeTypes = await ApiService.getJokeTypes();
      setState(() {
        jokeTypes = fetchedJokeTypes;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _loadRandomJoke() async {
    try {
      Joke? fetchedJoke = await ApiService.getRandomJoke();
      setState(() {
        randomJoke = fetchedJoke;
      });
    } catch (e) {
      setState(() {
        errorRandomJokeMessage = e.toString();
      });
    }
  }

  Future<void> _getRandomJoke() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    await _loadRandomJoke();
    Navigator.pop(context);
    if (randomJoke != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => RandomJokeScreen(randomJoke: randomJoke!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(errorRandomJokeMessage ?? "Error fetching joke")),
      );
    }
  }

  void _signOut() async {
    await AuthService().logout(context);
  }

  void showFavoriteScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const FavoriteJokesScreen()));
  }

  @override
  void initState() {
    super.initState();
    _loadJokeTypes();
    //setupNotificationListener();
  }

  @override
  Widget build(BuildContext context) {
    if (jokeTypes == null && errorMessage == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text("Error: $errorMessage")),
      );
    }

    var userEmail = AuthService().getUserEmail();

    return Scaffold(
      appBar: AppBar(
          title: Text("Hello, $userEmail"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _getRandomJoke,
              icon: const Icon(Icons.adb),
            ),
            IconButton(
              onPressed: showFavoriteScreen,
              icon: const Icon(Icons.star),
            ),
            IconButton(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
            ),
          ]),
      body: Column(
        children: [
          const Text(
            "Select a type of joke",
            style: TextStyle(fontSize: 28),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: JokeTypeListWidget(
              jokeTypeList: jokeTypes!,
            ),
          ),
        ],
      ),
    );
  }
}
