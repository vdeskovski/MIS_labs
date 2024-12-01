import 'package:lab2/models/joke_type.dart';

class Joke {
  final JokeType type;
  final String setup;
  final String punchline;
  final int id;

  Joke(this.type, this.setup, this.punchline, this.id);
}
