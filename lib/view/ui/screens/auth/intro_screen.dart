import 'package:flutter/material.dart';
import 'package:my_teeth/state/state_manager.dart';
import 'package:my_teeth/utils/shared_utils.dart';
import 'package:my_teeth/view/ui/widgets/intro_item.dart';
import 'package:my_teeth/view/ui/widgets/material_filled_button.dart';
import 'package:my_teeth/view/ui/widgets/material_text_button.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';
import '../../../../model/intro.dart';
import '../../../../utils/utils.dart';
import '../../widgets/intro_dot.dart';
import '../../widgets/material_outlined_button.dart';
import 'login_screen.dart';

class IntroScreen extends StatelessWidget {
  final pageController = PageController();

  final List<Intro> arrIntroItems = [
    const Intro(
      imagePath: IntroImages.introOne,
      title: Strings.introTitleOne,
      description: Strings.introDescriptionOne,
    ),
    const Intro(
      imagePath: IntroImages.introTwo,
      title: Strings.introTitleTwo,
      description: Strings.introDescriptionTwo,
    ),
    const Intro(
      imagePath: IntroImages.introThree,
      title: Strings.introTitleThree,
      description: Strings.introDescriptionThree,
    ),
  ];

  IntroScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: MaterialTextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(Strings.skip),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios_rounded, size: 12),
                  ],
                ),
                onPressed: () {
                  _goToLoginScreen(context);
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PageView.builder(
                  onPageChanged: (value) {
                    Provider.of<StateManager>(context, listen: false)
                        .setCurrentIntroPage(value);
                  },
                  controller: pageController,
                  itemCount: arrIntroItems.length,
                  itemBuilder: (context, index) {
                    return IntroItem(
                        imagePath: arrIntroItems[index].imagePath,
                        title: arrIntroItems[index].title,
                        description: arrIntroItems[index].description);
                  }),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: arrIntroItems
                  .map((e) => IntroDot(
                        isSelected: Provider.of<StateManager>(context)
                                .currentIntroPage ==
                            arrIntroItems.indexOf(e),
                        onTap: () {
                          pageController.animateToPage(
                            arrIntroItems.indexOf(e),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                child: Provider.of<StateManager>(context).currentIntroPage <
                        arrIntroItems.length - 1
                    ? MaterialOutlinedButton(
                        child: const Text(Strings.continueIntro),
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        })
                    : MaterialFilledButton(
                        child: const Text(Strings.getStarted,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          _goToLoginScreen(context);
                        },
                      )),
          ],
        ),
      ),
    );
  }

  void _goToLoginScreen(BuildContext context) {
    SharedUtils.getSharedPreferences()
        .setBool(SharedPreferencesKeys.isFirstTimeToOpen, false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }
}
