import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';

class EmptyReminderWidget extends StatelessWidget {
  const EmptyReminderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Lottie.asset(
              [Animations.sadOne, Animations.sadTwo][Random().nextInt(2)],
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20, width: double.infinity,),
            const Text(Strings.noRemindersFounded,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ],
    );
  }
}
