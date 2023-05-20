import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_teeth/state/state_manager.dart';
import 'package:my_teeth/view/screens/user/add_or_edit_reminder.dart';
import 'package:my_teeth/view/screens/user/home_screen.dart';
import 'package:my_teeth/view/screens/user/settings_screen.dart';
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
        child: PageView(
          controller: pageViewController,
          onPageChanged: (pageIndex) {
            Provider.of<StateManager>(context, listen: false)
                .setCurrentMainPage(pageIndex);
            Provider.of<StateManager>(context, listen: false)
                .setIsFloatingActionButtonVisible(pageIndex == 0);
          },
          children: [
            const HomeScreen(),
            NotificationsScreen(),
            const SettingsScreen()
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddOrEditReminder()));
                  },
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
