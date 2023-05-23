import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';
import '../../../controller/state_manager.dart';
import '../../../../utils/utils.dart';
import '../../widgets/material_filled_button.dart';
import '../../widgets/material_input.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      appBar: AppBar(
        title: Text(Strings.profile,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<StateManager>(builder: (context, provider, child) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: Form(
              key: provider.profileFormKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    splashColor: Theme.of(context).colorScheme.secondary,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  MaterialInput(const Text(Strings.name),
                      controller: provider.nameInProfileController,
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
                      controller: provider.emailInProfileController,
                      keyboardType: TextInputType.emailAddress,
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
                      controller: provider.passwordInProfileController,
                      isObscureText:
                      provider.passwordInProfileObscureTextState,
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
                                .setPasswordInProfileObscureTextState(
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
                      controller: provider.birthdateInProfileController,
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
                      child: const Text(Strings.editProfile,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (provider.profileFormKey.currentState!.validate()) {
                          await provider.updateProfile(context);
                        }
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _showDataPicker(BuildContext context, StateManager provider) {
    showDatePicker(
        context: context,
        initialDate: provider.birthdateInProfileController.text.isEmpty
            ? DateTime.now()
            : DateTime.parse(provider.birthdateInProfileController.text),
        firstDate: DateTime(1900),
        lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        provider.birthdateInProfileController.text =
            DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }
}
