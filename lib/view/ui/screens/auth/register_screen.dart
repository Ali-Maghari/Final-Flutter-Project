import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/constants/app_icons.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:my_teeth/view/ui/widgets/material_filled_button.dart';
import 'package:my_teeth/view/ui/widgets/material_input.dart';
import 'package:provider/provider.dart';
import '../../../../state/state_manager.dart';
import '../../widgets/material_text_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Utils.getUtils().setStatusBarAndNavigationBarColor(
      context,
      statusBarColorInLight: Theme.of(context).colorScheme.primary,
      navigationBarColorInLight: Theme.of(context).colorScheme.surface,
      statusBarColorInDark: Theme.of(context).colorScheme.surface,
      navigationBarColorInDark: Theme.of(context).colorScheme.surface,
    );
    return Scaffold(
      body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(
                  AppIcons.appIcon,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 60),
                Text("Welcome",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 16),
                Text("Create an account to continue",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 36),
                MaterialInput(const Text("Name"),
                    prefixIcon: Icon(Icons.person,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
                MaterialInput(const Text("Email"),
                    prefixIcon: Icon(Icons.email,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
                MaterialInput(
                  const Text("Password"),
                  isObscureText: Provider.of<StateManager>(context)
                      .passwordInLoginObscureTextState,
                  prefixIcon: Icon(Icons.lock,
                      color: Theme.of(context).colorScheme.primary),
                  suffixIcon: (isObscureText) {
                    return IconButton(
                      icon: Icon(
                          isObscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        Provider.of<StateManager>(context, listen: false)
                            .setPasswordInLoginObscureTextState(!isObscureText);
                      },
                    );
                  },
                ),
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
                MaterialInput(
                  const Text("Birthdate"),
                  controller: _birthdateController,
                  isObscureText: Provider.of<StateManager>(context)
                      .passwordInLoginObscureTextState,
                  prefixIcon: IconButton(
                    icon: Icon(Icons.calendar_month,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      // show a date picker
                      _showDataPicker(context);
                    },
                  ),
                  isReadOnly: true,
                ),
                const SizedBox(height: 40),
                MaterialFilledButton(
                    child: const Text('Sign up',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: () {}),
                const SizedBox(height: 6),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    MaterialTextButton(
                        child: const Text('Don\'t have an account? Sign up',
                            style: TextStyle(fontSize: 12)),
                        onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }

  void _showDataPicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: _birthdateController.text.isEmpty
                ? DateTime.now()
                : DateTime.parse(_birthdateController.text),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        _birthdateController.text = DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }
}
