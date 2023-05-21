import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:my_teeth/view/widgets/material_filled_button.dart';
import 'package:my_teeth/view/widgets/material_input.dart';
import 'package:provider/provider.dart';
import '../../../../constants/strings.dart';
import '../../../controller/state_manager.dart';
import '../../../../utils/shared_utils.dart';
import '../../widgets/material_text_button.dart';
import '../user/main_screen.dart';

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
      body: Consumer<StateManager>(builder: (context, provider, child) {
        return Container(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Form(
                key: provider.registerFormKey,
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
                    Text(Strings.welcome,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Theme.of(context).colorScheme.primary)),
                    const SizedBox(height: 16),
                    Text(Strings.createAnAccountToContinue,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary)),
                    const SizedBox(height: 36),
                    MaterialInput(const Text(Strings.name),
                        prefixIcon: Icon(Icons.person,
                            color: Theme.of(context).colorScheme.primary),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.nameIsRequired;
                        }
                        return null;
                      }),
                    const SizedBox(
                        height: Margins.inputsMarginWhenErrorNotEnabled),
                    MaterialInput(const Text(Strings.email),
                        prefixIcon: Icon(Icons.email,
                            color: Theme.of(context).colorScheme.primary),
                        validator: (text) {
                      if (text == null || text.isEmpty) {
                        return Strings.emailIsRequired;
                      } else if (!Utils.getUtils().isValidEmail(text)) {
                        return Strings.emailIsInvalid;
                      }
                      return null;
                    }),
                    const SizedBox(
                        height: Margins.inputsMarginWhenErrorNotEnabled),
                    MaterialInput(const Text(Strings.password),
                        isObscureText:
                            provider.passwordInRegisterObscureTextState,
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
                              .setPasswordInRegisterObscureTextState(
                                  !isObscureText);
                        },
                      );
                    }, validator: (text) {
                      if (text == null || text.isEmpty) {
                        return Strings.passwordIsRequired;
                      } else if (Utils.getUtils().isValidPassword(text)) {
                        return Strings.passwordIsInvalid;
                      }
                      return null;
                    }),
                    const SizedBox(
                        height: Margins.inputsMarginWhenErrorNotEnabled),
                    MaterialInput(
                      const Text(Strings.birthdate),
                      controller: _birthdateController,
                      prefixIcon: IconButton(
                        icon: Icon(Icons.calendar_month,
                            color: Theme.of(context).colorScheme.primary),
                        onPressed: () {
                          _showDataPicker(context);
                        },
                      ),
                      onTap: () {
                        _showDataPicker(context);
                      },
                      isReadOnly: true,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return Strings.birthdateIsRequired;
                          }
                          return null;
                        }),
                    const SizedBox(height: 40),
                    MaterialFilledButton(
                        child: const Text(Strings.signUp,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          provider.registerFormKey.currentState!.validate();
                          if (provider.registerFormKey.currentState!.validate()) {
                            // clear all previous stack and push home screen
                            SharedUtils.getSharedUtils().setBool(
                                SharedPreferencesKeys.isUserLoggedIn, true);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()),
                                    (route) => false);
                          }
                        }),
                    const SizedBox(height: 6),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        MaterialTextButton(
                            child: const Text(Strings.alreadyHaveAnAccount,
                                style: TextStyle(fontSize: 12)),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
      }),
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
