import 'package:flutter/material.dart';
import 'package:lab1/models/Clothing.dart';

class ClothingDetailsScreen extends StatelessWidget {
  const ClothingDetailsScreen({super.key, required this.clothing});

  final Clothing clothing;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(clothing.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: clothing.description,
              child: Image.network(
                clothing.picture,
                width: double.infinity,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        clothing.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.euro),
                          Text(clothing.price.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  clothing.description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                )),
          ],
        ),
      ),
    );
  }
}
