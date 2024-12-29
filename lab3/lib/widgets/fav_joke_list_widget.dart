import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/firestore_service.dart';

class FavoriteJokeListWidget extends StatelessWidget {
  const FavoriteJokeListWidget(
      {super.key, required this.jokeList, required this.fetchJokes});

  final List<Joke> jokeList;
  final Future<void> Function() fetchJokes;

  void removeFromFavourites(BuildContext context, Joke joke) async {
    await FireStorageService().removeJokeFromFavorites(joke);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Joke removed from favorites!'),
        duration: Duration(seconds: 2),
      ),
    );
    await fetchJokes();
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
                          removeFromFavourites(ctx, jokeList[index]);
                        },
                        child: const Icon(Icons.star),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
