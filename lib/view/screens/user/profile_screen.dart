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
  ProfileScreen({super.key});

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
      body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
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
                    prefixIcon: Icon(Icons.person,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
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
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
                MaterialInput(
                  const Text(Strings.birthdate),
                  controller: _birthdateController,
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
                    child: const Text(Strings.editProfile,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: () {

                    }),
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
