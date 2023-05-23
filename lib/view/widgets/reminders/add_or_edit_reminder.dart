import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/model/reminder/reminder.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../material_filled_button.dart';
import '../material_input.dart';

class AddOrEditReminder extends StatelessWidget {

  final Reminder? editedReminder;

  const AddOrEditReminder({super.key, this.editedReminder});

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
              Center(
                child: Text(editedReminder == null ? Strings.addNewReminder : Strings.editReminder,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).colorScheme.primary)),
              ),
              const SizedBox(height: 40),
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
                  child: Text(editedReminder == null ? Strings.addReminder : Strings.editReminder,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    provider.addOrEditReminderFormKey.currentState!.validate();
                    if (provider.addOrEditReminderFormKey.currentState!
                        .validate()) {
                      Reminder reminder = Reminder(
                        title: provider.titleControllerInAddOrEditReminderBottomSheet.text,
                        time: DateFormat("hh:mm a").parse(provider.timeControllerInAddOrEditReminderBottomSheet.text).millisecondsSinceEpoch,
                        description: provider.descriptionControllerInAddOrEditReminderBottomSheet.text);
                      if (editedReminder == null) {
                        provider.addReminder(context, reminder);
                      }
                      else {
                        provider.updateReminder(context, editedReminder!, reminder);
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
