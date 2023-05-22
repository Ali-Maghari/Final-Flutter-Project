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
    return Consumer<StateManager>(builder: (context, provider, child) {
      return Center(
        child: Form(
          key: provider.addOrEditReminderFormKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              MaterialInput(const Text(Strings.title),
                  controller:
                      provider.titleControllerInAddOrEditReminderBottomSheet,
                  prefixIcon: Icon(Icons.title_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  validator: (text) {
                if (text == null || text.isEmpty) {
                  return Strings.reminderTitleRequired;
                }
                return null;
              }),
              const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
              MaterialInput(const Text(Strings.reminderTime),
                  controller:
                      provider.timeControllerInAddOrEditReminderBottomSheet,
                  prefixIcon: IconButton(
                    icon: Icon(Icons.access_time_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      // show a time picker
                      _showTimePicker(context, provider);
                    },
                  ),
                  onTap: () {
                    _showTimePicker(context, provider);
                  },
                  isReadOnly: true,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return Strings.reminderTimeRequired;
                    }
                    return null;
                  }),
              const SizedBox(height: Margins.inputsMarginWhenErrorNotEnabled),
              MaterialInput(const Text(Strings.description),
                  controller: provider
                      .descriptionControllerInAddOrEditReminderBottomSheet,
                  helperText: Strings.optional,
                  prefixIcon: Icon(Icons.description_outlined,
                      color: Theme.of(context).colorScheme.primary)),
              const SizedBox(height: 40),
              MaterialFilledButton(
                  child: const Text(Strings.addReminder,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    provider.addOrEditReminderFormKey.currentState!.validate();
                    if (provider.addOrEditReminderFormKey.currentState!
                        .validate()) {
                      Navigator.of(context).pop();
                      Utils.getUtils().showSnackBar(
                          context: context,
                          message: Strings.reminderAddedSuccessfully,
                          duration: 1400);
                    }
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  void _showTimePicker(BuildContext context, StateManager provider) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        provider.timeControllerInAddOrEditReminderBottomSheet.text =
            value.format(context);
      }
    });
  }
}
