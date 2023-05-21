import 'package:flutter/material.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../material_filled_button.dart';
import '../material_input.dart';

class AddOrEditReminder extends StatelessWidget {
  const AddOrEditReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            controller: Provider.of<StateManager>(context)
                .timeControllerInAddOrEditReminderBottomSheet,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                Utils.getUtils().showSnackBar(
                    context: context,
                    message: Strings.reminderAddedSuccessfully,
                    duration: 1400);
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        Provider.of<StateManager>(context, listen: false)
            .timeControllerInAddOrEditReminderBottomSheet
            .text = value.format(context);
      }
    });
  }
}
