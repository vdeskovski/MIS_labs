import 'package:flutter/material.dart';
import 'package:lab1/screens/ClothingListScreen.dart';

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
      theme: theme,
      title: 'Lab1',
      home: const ClothingListScreen(),
    );
  }
}
