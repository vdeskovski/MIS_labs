class JokeType {
  final String name;

  const JokeType({required this.name});

  factory JokeType.fromJson(String jokeType) {
    return JokeType(name: jokeType);
  }
}
