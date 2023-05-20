import 'package:flutter/material.dart';
import 'package:my_teeth/view/widgets/settings/setting_widget.dart';

import '../../../../constants/strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Expanded(
        child: Column(
          children: const [
            SizedBox(height: 20),
            SettingWidget(title: Strings.theme, icon: Icon(Icons.brightness_4_outlined)),
            SettingWidget(title: Strings.rewards, icon: Icon(Icons.card_giftcard_outlined)),
            SettingWidget(title: Strings.logout, icon: Icon(Icons.logout_outlined)),
          ],
        ),
      ),
    );
  }
}
