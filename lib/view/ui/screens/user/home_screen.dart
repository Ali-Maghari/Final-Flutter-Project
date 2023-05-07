import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_teeth/constants/constants.dart';
import '../../../../constants/strings.dart';
import '../../../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.getUtils().setStatusBarAndNavigationBarColor(
      context,
      statusBarColorInLight: Theme.of(context).colorScheme.primary,
      navigationBarColorInLight: Theme.of(context).colorScheme.surfaceVariant,
      statusBarColorInDark: Theme.of(context).colorScheme.surface,
      navigationBarColorInDark: Theme.of(context).colorScheme.surfaceVariant,
    );
    return Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Flexible(
                      child: Text(
                        "Welcome test user name",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Lottie.asset(
                    "assets/animations/welcome.json",
                    width: 26,
                    height: 26,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Theme.of(context).colorScheme.surfaceVariant,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          selectedIndex: 0,
          onDestinationSelected: (index) {},
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: Strings.home,
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              label: Strings.notifications,
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              label: Strings.settings,
            ),
          ],
        ));
  }
}
