import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/model/database/db.dart';
import 'package:my_teeth/model/user/user_manager.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:my_teeth/view/widgets/material_filled_button.dart';
import 'package:my_teeth/view/widgets/material_input.dart';
import 'package:provider/provider.dart';
import '../../../../constants/strings.dart';
import '../../../controller/state_manager.dart';
import '../../../model/user/user.dart';
import '../../widgets/material_text_button.dart';
import '../user/main_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final UserManager _userManager = UserManager.getUserManager();

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
                        controller: provider.nameInRegisterController,
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
                        controller: provider.emailInRegisterController,
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
                        controller: provider.passwordInRegisterController,
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
                    MaterialInput(const Text(Strings.birthdate),
                        controller: provider.birthdateInRegisterController,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.calendar_month,
                              color: Theme.of(context).colorScheme.primary),
                          onPressed: () {
                            _showDataPicker(context, provider);
                          },
                        ),
                        onTap: () {
                          _showDataPicker(context, provider);
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
                        onPressed: () async {
                          provider.registerFormKey.currentState!.validate();
                          if (provider.registerFormKey.currentState!
                              .validate()) {
                            User user = User(
                              name: provider.nameInRegisterController.text,
                              email: provider.emailInRegisterController.text,
                              password:
                                  provider.passwordInRegisterController.text,
                              birthdate: DateTime.parse(provider
                                      .birthdateInRegisterController.text)
                                  .millisecondsSinceEpoch,
                            );
                            user.id = await Db.getDatabaseHelper()
                                .getUserDataHelper()
                                .insertUser(user);
                            _userManager.setCurrentUser(user);
                            _userManager.login();
                            // clear all previous stack and push home screen
                            if(context.mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                      (route) => false);
                            }
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

  void _showDataPicker(BuildContext context, StateManager provider) {
    showDatePicker(
            context: context,
            initialDate: provider.birthdateInRegisterController.text.isEmpty
                ? DateTime.now()
                : DateTime.parse(provider.birthdateInRegisterController.text),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        provider.birthdateInRegisterController.text =
            DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }
}
