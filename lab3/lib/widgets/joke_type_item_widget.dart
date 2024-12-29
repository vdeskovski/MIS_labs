import 'package:flutter/material.dart';
import 'package:lab3/models/joke_type.dart';

class JokeTypeItemWidget extends StatelessWidget {
  const JokeTypeItemWidget(
      {super.key, required this.jokeType, required this.onJokeTypeClick});

  final JokeType jokeType;
  final void Function(BuildContext context, JokeType jokeType) onJokeTypeClick;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        onJokeTypeClick(context, jokeType);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                jokeType.name,
                style: const TextStyle(fontSize: 21),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
