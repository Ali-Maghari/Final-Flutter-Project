import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_teeth/constants/app_icons.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:my_teeth/view/ui/screens/auth/register_screen.dart';
import 'package:my_teeth/view/ui/widgets/material_filled_button.dart';
import 'package:my_teeth/view/ui/widgets/material_input.dart';
import 'package:provider/provider.dart';
import '../../../../state/state_manager.dart';
import '../../widgets/material_text_button.dart';

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
                Text("Welcome back !",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 16),
                Text("Sign in to continue",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 36),
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
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    MaterialTextButton(
                        child: const Text('Forgot password?',
                            style: TextStyle(fontSize: 12)),
                        onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 20),
                MaterialFilledButton(
                    child: const Text('Sign in',
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
