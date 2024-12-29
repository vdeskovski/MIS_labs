import 'package:flutter/material.dart';
import 'package:lab3/models/joke.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({super.key, required this.randomJoke});

  final Joke randomJoke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random joke of type: ${randomJoke.type.name}"),
      ),
      body: SizedBox(
        height: 200,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  randomJoke.setup,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(randomJoke.punchline,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
