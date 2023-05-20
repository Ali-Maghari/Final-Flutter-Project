import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/utils/shared_utils.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:my_teeth/view/screens/auth/register_screen.dart';
import 'package:my_teeth/view/widgets/material_filled_button.dart';
import 'package:my_teeth/view/widgets/material_input.dart';
import 'package:provider/provider.dart';
import '../../../../constants/strings.dart';
import '../../../../state/state_manager.dart';
import '../../widgets/material_text_button.dart';
import '../user/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                Text(Strings.welcomeBack,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 16),
                Text(Strings.signInToContinue,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 36),
                MaterialInput(const Text(Strings.email),
                    prefixIcon: Icon(Icons.email,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
                MaterialInput(
                  const Text(Strings.password),
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
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    MaterialTextButton(
                        child: const Text(Strings.forgotPassword,
                            style: TextStyle(fontSize: 12)),
                        onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 20),
                MaterialFilledButton(
                    child: const Text(Strings.signIn,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      SharedUtils.getSharedUtils().setBool(SharedPreferencesKeys.isUserLoggedIn, true);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MainScreen()));
                    }),
                const SizedBox(height: 6),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    MaterialTextButton(
                        child: const Text(Strings.notHaveAnAccount,
                            style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
