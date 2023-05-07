import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_teeth/utils/shared_utils.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:my_teeth/view/ui/screens/auth/intro_screen.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';
import '../user/home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  void _navigateToLoginScreen() async {
    await Future.delayed(const Duration(milliseconds: 2600));
    if (context.mounted) {
      Widget redirectWidget;
      if (SharedUtils.getSharedUtils()
              .getBool(SharedPreferencesKeys.isFirstTimeToOpen) ??
          true) {
        redirectWidget = IntroScreen();
      } else if (SharedUtils.getSharedUtils()
              .getBool(SharedPreferencesKeys.isUserLoggedIn) ??
          false) {
        redirectWidget = const HomeScreen();
      } else {
        redirectWidget = const LoginScreen();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => redirectWidget),
      );
    }
  }

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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.appIcon,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 26),
            Text(Strings.appName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.primary)),
          ],
        )),
      ),
    );
  }
}
