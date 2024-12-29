import 'package:lab3/models/joke_type.dart';

class Joke {
  final JokeType type;
  final String setup;
  final String punchline;
  final int id;

  Joke(this.type, this.setup, this.punchline, this.id);

  Map<String, dynamic> toMap() {
    return {
      'setup': setup,
      'punchline': punchline,
      'id': id,
    };
  }

  Joke.simple(this.setup, this.punchline, this.id)
      : type = JokeType(name: "general");

  factory Joke.fromMap(Map<String, dynamic> map) {
    return Joke.simple(
      map['setup'] as String,
      map['punchline'] as String,
      map['id'] as int,
    );
  }
}
