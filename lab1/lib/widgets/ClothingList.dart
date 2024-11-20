import 'package:flutter/material.dart';
import 'package:lab1/data/dummy_data.dart';
import 'package:lab1/models/Clothing.dart';

import '../screens/ClothingDetailsScreen.dart';
import 'ClothingItem.dart';

class ClothingList extends StatelessWidget {
  const ClothingList({super.key});

  void selectClothes(BuildContext context, Clothing clothing) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => ClothingDetailsScreen(clothing: clothing)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: clothes.length,
        itemBuilder: (ctx, index) => ClothingItem(
            clothing: clothes[index], onSelectClothing: selectClothes));
  }
}
