import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab3/models/joke.dart';

import '../services/firestore_service.dart';

class JokeListWidget extends StatelessWidget {
  const JokeListWidget({super.key, required this.jokeList});

  final List<Joke> jokeList;

  void addToFavourites(BuildContext context, Joke joke) async {
    await FireStorageService().addJokeToFavorites(joke);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Joke added to favorites!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

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
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          addToFavourites(ctx, jokeList[index]);
                        },
                        child: const Icon(Icons.star_border),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
