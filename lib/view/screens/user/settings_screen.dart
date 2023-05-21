import 'package:flutter/material.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/model/user/user_manager.dart';
import 'package:my_teeth/view/widgets/settings/setting_widget.dart';
import 'package:provider/provider.dart';
import '../../../../constants/strings.dart';
import '../../../constants/constants.dart';
import '../../../model/shared_preferences/shared_utils.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final UserManager _userManager = UserManager.getUserManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.settings),
        elevation: 2,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const SettingWidget(
              title: Strings.theme, icon: Icon(Icons.brightness_4_outlined)),
          const SettingWidget(
              title: Strings.rewards, icon: Icon(Icons.card_giftcard_outlined)),
          SettingWidget(
            title: Strings.logout,
            icon: const Icon(Icons.logout_outlined),
            onTap: () {
              Provider.of<StateManager>(context, listen: false).currentMainPage = 0;
              Provider.of<StateManager>(context, listen: false).isFloatingActionButtonVisible = true;
              Provider.of<StateManager>(context, listen: false).isFloatingActionButtonExtended = true;
              _userManager.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
