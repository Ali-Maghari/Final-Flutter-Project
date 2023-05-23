import 'package:flutter/material.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../constants/strings.dart';
import '../../../controller/state_manager.dart';
import '../../widgets/material_filled_button.dart';

class ThemesScreen extends StatelessWidget {
  const ThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.theme),
          elevation: 2,
        ),
        body: Consumer<StateManager>(builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const SizedBox(height: 20),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(Strings.appTheme, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 16),
              RadioListTile(
                  title: const Text(Strings.mainAppTheme),
                  value: AppTheme.mainAppTheme,
                  groupValue: provider.appThemeInThemesScreen,
                  onChanged: (value) {
                    provider.setAppTheme(value!);
                  }),
              RadioListTile(
                  title: const Text(Strings.dynamicAppTheme),
                  value: AppTheme.dynamicAppTheme,
                  groupValue: provider.appThemeInThemesScreen,
                  onChanged: (value) {
                    provider.setAppTheme(value!);
                  }),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(Strings.appThemeMode, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 16),
              RadioListTile(
                  title: const Text(Strings.light),
                  value: AppThemeMode.light,
                  groupValue: provider.appThemeModeInThemesScreen,
                  onChanged: (value) {
                    provider.setAppThemeMode(value!);
                  }),
              RadioListTile(
                  title: const Text(Strings.dark),
                  value: AppThemeMode.dark,
                  groupValue: provider.appThemeModeInThemesScreen,
                  onChanged: (value) {
                    provider.setAppThemeMode(value!);
                  }),
              RadioListTile(
                  title: const Text(Strings.followSystem),
                  value: AppThemeMode.followSystem,
                  groupValue: provider.appThemeModeInThemesScreen,
                  onChanged: (value) {
                    provider.setAppThemeMode(value!);
                  }),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: MaterialFilledButton(
                    child: const Text(Strings.applyTheme,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      provider.applyTheme();
                    }),
              ),
              const SizedBox(height: 20),
            ],
          );
        }));
  }
}
