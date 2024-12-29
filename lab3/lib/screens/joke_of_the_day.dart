import 'package:flutter/material.dart';
import 'package:lab3/models/joke.dart';
import 'package:lab3/services/api_services.dart';

import '../services/firestore_service.dart';
import 'joke_type_list_screen.dart';

class JokeOfTheDay extends StatefulWidget {
  const JokeOfTheDay({super.key});

  @override
  State<JokeOfTheDay> createState() => _JokeOfTheDayState();
}

class _JokeOfTheDayState extends State<JokeOfTheDay> {
  Joke? joke;

  void getTodaysJoke() async {
    Joke? fetchedJoke = await ApiService.getRandomJoke();
    setState(() {
      joke = fetchedJoke;
    });
  }

  @override
  void initState() {
    super.initState();
    getTodaysJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke of the Day'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => JokeTypeListScreen()));
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: joke == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: 200,
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        joke!.setup,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text(joke!.punchline,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
