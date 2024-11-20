import 'package:flutter/material.dart';
import 'package:lab1/widgets/ClothingList.dart';

class ClothingListScreen extends StatelessWidget {
  const ClothingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("213159"),
      ),
      body: const ClothingList(),
    );
  }
}
