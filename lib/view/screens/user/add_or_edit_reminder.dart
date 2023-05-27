import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/model/reminder/reminder.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../../../utils/utils.dart';
import '../../widgets/material_filled_button.dart';
import '../../widgets/material_input.dart';

class AddOrEditReminder extends StatelessWidget {

  final Reminder? editedReminder;

  const AddOrEditReminder({super.key, this.editedReminder});

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
        title: Text(editedReminder == null ? Strings.addNewReminder : Strings.editReminder,
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
                    child: Text(editedReminder == null ? Strings.addReminder : Strings.editReminder,
                        style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      if (provider.addOrEditReminderFormKey.currentState!.validate()) {
                        if (editedReminder == null) {
                          await provider.addReminder(context);
                        }
                        else {
                          await provider.updateReminder(context, editedReminder!);
                        }
                      }
                    }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
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
