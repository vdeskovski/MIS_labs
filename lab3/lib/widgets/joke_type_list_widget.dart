import 'package:flutter/material.dart';

import '../models/joke_type.dart';
import '../screens/joke_list_screen.dart';
import 'joke_type_item_widget.dart';

class JokeTypeListWidget extends StatelessWidget {
  const JokeTypeListWidget({super.key, required this.jokeTypeList});

  final List<JokeType> jokeTypeList;

  void _onJokeTypeClick(BuildContext context, JokeType jokeType) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => JokeListScreen(
              jokeType: jokeType,
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: jokeTypeList.length,
        itemBuilder: (ctx, index) => JokeTypeItemWidget(
            jokeType: jokeTypeList[index], onJokeTypeClick: _onJokeTypeClick));
  }
}
