import 'package:flutter/material.dart';
import 'package:lab2/models/joke.dart';

class JokeListWidget extends StatelessWidget {
  const JokeListWidget({super.key, required this.jokeList});

  final List<Joke> jokeList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: jokeList.length,
        itemBuilder: (ctx, index) => SizedBox(
              height: 200,
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        jokeList[index].setup,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text(jokeList[index].punchline,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18))
                    ],
                  ),
                ),
              ),
            ));
  }
}
