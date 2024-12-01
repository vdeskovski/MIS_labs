import 'package:http/http.dart' as http;
import 'package:lab2/models/joke.dart';
import 'dart:convert';

import 'package:lab2/models/joke_type.dart';

class ApiService {
  static Future<List<JokeType>> getJokeTypes() async {
    var response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    List<dynamic> jsonList = jsonDecode(response.body);
    List<JokeType> jokeTypes =
        jsonList.map((e) => JokeType.fromJson(e as String)).toList();
    return jokeTypes;
  }

  static Future<List<Joke>?> getJokesByType(String jokeType) async {
    var response = await http.get(
        Uri.parse("https://official-joke-api.appspot.com/jokes/$jokeType/ten"));
    List<dynamic> json = jsonDecode(response.body);
    List<Joke> jokes = json.map((jokeJson) {
      return Joke(
        JokeType(name: jokeJson['type']),
        jokeJson['setup'] as String,
        jokeJson['punchline'] as String,
        jokeJson['id'] as int,
      );
    }).toList();
    return jokes;
  }

  static Future<Joke?> getRandomJoke() async {
    var response = await http
        .get(Uri.parse("http://www.official-joke-api.appspot.com/random_joke"));
    Map<String, dynamic> json = jsonDecode(response.body);
    JokeType jokeType = JokeType(name: json["type"]);
    Joke joke = Joke(jokeType, json["setup"], json["punchline"], json["id"]);
    return joke;
  }
}
