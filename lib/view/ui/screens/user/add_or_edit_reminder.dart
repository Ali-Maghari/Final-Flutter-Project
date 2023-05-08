import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';
import '../../../../utils/utils.dart';
import '../../widgets/material_filled_button.dart';
import '../../widgets/material_input.dart';

class AddOrEditReminder extends StatelessWidget {
  AddOrEditReminder({super.key});

  final TextEditingController _timeController = TextEditingController();

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
        title: Text(Strings.addReminder,
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
                MaterialInput(const Text(Strings.title),
                    prefixIcon: Icon(Icons.title_outlined,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
                MaterialInput(const Text(Strings.description),
                    prefixIcon: Icon(Icons.description_outlined,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
                MaterialInput(
                  const Text(Strings.reminderTime),
                  controller: _timeController,
                  prefixIcon: IconButton(
                    icon: Icon(Icons.access_time_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      // show a time picker
                      _showTimePicker(context);
                    },
                  ),
                  isReadOnly: true,
                ),
                const SizedBox(height: 40),
                MaterialFilledButton(
                    child: const Text(Strings.addReminder,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showSnackBar(context);
                    }),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        _timeController.text = value.format(context);
      }
    });
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(Strings.reminderAddedSuccessfully),
        duration: const Duration(milliseconds: 1500),
        width: MediaQuery.of(context).size.width * 0.96,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

}