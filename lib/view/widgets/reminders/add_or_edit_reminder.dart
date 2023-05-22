import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/model/reminder/reminder.dart';
import 'package:my_teeth/model/user/user.dart';
import 'package:my_teeth/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../../../model/database/db.dart';
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
                  onPressed: () async {
                    provider.addOrEditReminderFormKey.currentState!.validate();
                    if (provider.addOrEditReminderFormKey.currentState!
                        .validate()) {
                      Reminder reminder = Reminder(
                        title: provider
                            .titleControllerInAddOrEditReminderBottomSheet.text,
                        time: DateFormat("hh:mm a").parse(provider
                            .timeControllerInAddOrEditReminderBottomSheet
                            .text)
                            .millisecondsSinceEpoch,
                        description: provider
                            .descriptionControllerInAddOrEditReminderBottomSheet
                            .text,
                      );
                      User? currentUser =
                          await provider.userManager.getCurrentUser();
                      reminder.userId = currentUser!.id;
                      reminder.id = await Db.getDatabaseHelper()
                          .getReminderDataHelper()
                          .insertReminder(reminder);
                      if (reminder.id == -1) {
                        if (context.mounted) {
                          Utils.getUtils().showSnackBar(
                              context: context,
                              message: Strings.reminderAlreadyExists,
                              animation: Animations.sadThree);
                          Navigator.of(context).pop();
                        }
                        return;
                      }
                      provider.addReminder(reminder);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        Utils.getUtils().showSnackBar(
                            context: context,
                            message: Strings.reminderAddedSuccessfully,
                            duration: 1400);
                      }
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
      initialTime: provider.timeControllerInAddOrEditReminderBottomSheet.text
              .isEmpty
          ? TimeOfDay.now()
          : TimeOfDay.fromDateTime(DateFormat("hh:mm a").parse(provider
              .timeControllerInAddOrEditReminderBottomSheet.text)),
    ).then((value) {
      if (value != null) {
        provider.timeControllerInAddOrEditReminderBottomSheet.text =
            value.format(context);
      }
    });
  }
}
