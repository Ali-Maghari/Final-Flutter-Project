import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          Animations.sadOne,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        const Text(Strings.noRemindersFounded,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}