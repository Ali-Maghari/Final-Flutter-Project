import 'package:flutter/material.dart';
import 'package:my_teeth/view/widgets/reminders/add_or_edit_reminder.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings.dart';
import '../../../../utils/utils.dart';
import '../../widgets/material_filled_button.dart';
import '../../widgets/material_input.dart';
import '../../widgets/reminders/reminder_widget.dart';

class Reminders extends StatelessWidget {
  Reminders({super.key});

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
        title: Text(Strings.reminders,
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
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: const [
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                    Reminder(),
                  ],
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          tooltip: Strings.addNewReminder,
          icon: Icon(Icons.add_outlined,
              color: Theme.of(context).colorScheme.onSurface),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return const AddOrEditReminder();
              },
            );
          },
          label: const Text(Strings.addNewReminder)),
    );
  }
}
