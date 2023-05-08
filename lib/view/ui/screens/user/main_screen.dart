import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/state/state_manager.dart';
import 'package:my_teeth/view/ui/screens/user/home_screen.dart';
import 'package:my_teeth/view/ui/screens/user/settings_screen.dart';
import 'package:provider/provider.dart';
import '../../../../constants/strings.dart';
import '../../../../utils/utils.dart';
import 'notifications_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final PageController pageViewController = PageController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Utils.getUtils().setStatusBarAndNavigationBarColor(
      context,
      statusBarColorInLight: Theme.of(context).colorScheme.primary,
      navigationBarColorInLight: Theme.of(context).colorScheme.surfaceVariant,
      statusBarColorInDark: Theme.of(context).colorScheme.surface,
      navigationBarColorInDark: Theme.of(context).colorScheme.surfaceVariant,
    );
    _onScroll(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          controller: scrollController,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(
                controller: pageViewController,
                onPageChanged: (pageIndex) {
                  Provider.of<StateManager>(context, listen: false)
                      .setCurrentMainPage(pageIndex);
                  Provider.of<StateManager>(context, listen: false)
                      .setIsFloatingActionButtonVisible(pageIndex == 0);
                },
                children: [const HomeScreen(), NotificationsScreen(), const SettingsScreen()],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Theme.of(context).colorScheme.surfaceVariant,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        selectedIndex: Provider.of<StateManager>(context).currentMainPage,
        onDestinationSelected: (index) {
          Provider.of<StateManager>(context, listen: false)
              .setCurrentMainPage(index);
          pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
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
      ),
      floatingActionButton:
          Provider.of<StateManager>(context).isFloatingActionButtonVisible
              ? FloatingActionButton.extended(
                  isExtended: Provider.of<StateManager>(context)
                      .isFloatingActionButtonExtended,
                  tooltip: Strings.addCleaningReminder,
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                  label: const Text(Strings.addCleaningReminder))
              : const SizedBox(),
    );
  }

  void _onScroll(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        Provider.of<StateManager>(context, listen: false)
            .setIsFloatingActionButtonExtended(false);
      } else {
        Provider.of<StateManager>(context, listen: false)
            .setIsFloatingActionButtonExtended(true);
      }
    });
  }
}
