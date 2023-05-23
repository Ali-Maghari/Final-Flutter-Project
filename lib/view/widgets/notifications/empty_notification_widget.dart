import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';

class EmptyNotificationWidget extends StatelessWidget {
  const EmptyNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Lottie.asset(
                Animations.sadTwo,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20, width: double.infinity,),
              const Text(Strings.noNotificationsFounded,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
