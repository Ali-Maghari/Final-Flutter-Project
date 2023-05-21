import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import 'my_app_bar.dart';

class EmptyHomeWidget extends StatelessWidget {
  const EmptyHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppBar(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
          ),
        ),
      ],
    );
  }
}