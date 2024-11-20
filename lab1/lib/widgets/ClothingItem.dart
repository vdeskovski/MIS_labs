import 'package:flutter/material.dart';
import 'package:lab1/models/Clothing.dart';
import 'package:transparent_image/transparent_image.dart';

class ClothingItem extends StatelessWidget {
  const ClothingItem(
      {super.key, required this.clothing, required this.onSelectClothing});

  final Clothing clothing;
  final void Function(BuildContext context, Clothing clothing) onSelectClothing;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onSelectClothing(context, clothing);
        },
        child: Stack(
          children: [
            Hero(
              tag: clothing.description,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(clothing.picture),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 44),
                color: Colors.black54,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          clothing.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.euro),
                            Text(
                              clothing.price.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
