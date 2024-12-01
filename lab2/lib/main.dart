import 'package:flutter/material.dart';
import 'package:lab2/screens/joke_type_list_screen.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(0, 57, 62, 70),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab2',
      theme: theme,
      home: JokeTypeListScreen(),
    );
  }
}
