import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const IntroItem(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(shrinkWrap: true, children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          imagePath,
          height: 180,
        ),
        const SizedBox(height: 60),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
