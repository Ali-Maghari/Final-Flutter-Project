import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/constants.dart';
import '../../screens/user/profile_screen.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Flexible(
                  child: Text(
                "Welcome Ali Maghari",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                width: 8,
              ),
              Lottie.asset(
                Animations.welcome,
                width: 26,
                height: 26,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
