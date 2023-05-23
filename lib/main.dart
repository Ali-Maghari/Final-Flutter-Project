import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/model/database/db.dart';
import 'package:my_teeth/model/shared_preferences/shared_utils.dart';
import 'package:provider/provider.dart';
import 'package:my_teeth/view/screens/auth/splash_screen.dart';
import 'color/color_schemes.dart' as color_schemes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedUtils.init();
  await Db.init("my_teeth");
  runApp(ChangeNotifierProvider<StateManager>(
      create: (context) => StateManager(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateManager>(builder: (context, provider, child) {
      return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null && provider.appTheme == AppTheme.dynamicAppTheme) {
          lightColorScheme = lightDynamic.harmonized()
            ..copyWith(primary: color_schemes.lightColorScheme.primary);
          darkColorScheme = darkDynamic.harmonized()
            ..copyWith(primary: color_schemes.darkColorScheme.primary);
        } else {
          lightColorScheme = color_schemes.lightColorScheme;
          darkColorScheme = color_schemes.darkColorScheme;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: provider.appThemeMode == AppThemeMode.light
                  ? lightColorScheme
                  : provider.appThemeMode == AppThemeMode.dark ? darkColorScheme : lightColorScheme,
              fontFamily: 'AppFont'),
          darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: provider.appThemeMode == AppThemeMode.dark
                  ? darkColorScheme
                  : provider.appThemeMode == AppThemeMode.light ? lightColorScheme : darkColorScheme,
              fontFamily: 'AppFont'),
          home: const SplashScreen(),
        );
      });
    });
  }
}
