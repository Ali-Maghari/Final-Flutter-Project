import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/view/screens/user/add_or_edit_reminder.dart';
import 'package:my_teeth/view/widgets/reminders/empty_reminder_widget.dart';
import 'package:my_teeth/view/widgets/reminders/reminder_details.dart';
import 'package:provider/provider.dart';
import '../../../../constants/strings.dart';
import '../../../../utils/utils.dart';
import '../../../model/reminder/reminder.dart';
import '../../widgets/reminders/reminder_widget.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key});

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
      body:
    Consumer<StateManager>(builder: (context, provider, child) {
      return Container(
          color: Theme.of(context).colorScheme.surface,
          child: FutureBuilder<List<Reminder>>(
              future: getUserReminders(context, provider),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Reminder>> snapshot) {
                return snapshot.data == null || snapshot.data!.isEmpty
                    ? Container(
                  alignment: Alignment.center,
                  child: const EmptyReminderWidget(),
                )
                    : ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: snapshot.data!.map((reminder) {
                        return ReminderItem(
                          reminder: reminder,
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return ReminderDetails(reminder: reminder);
                              },
                            );
                          },
                          onAvatarPressed: () {
                            provider.titleControllerInAddOrEditReminderBottomSheet.text = reminder.title ?? '';
                            provider.timeControllerInAddOrEditReminderBottomSheet.text = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(reminder.time ?? 0));
                            provider.descriptionControllerInAddOrEditReminderBottomSheet.text = reminder.description ?? '';
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddOrEditReminder(editedReminder: reminder)));
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
              }));
    }),
      floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          tooltip: Strings.addNewReminder,
          icon: Icon(Icons.add_outlined,
              color: Theme.of(context).colorScheme.onSurface),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddOrEditReminder()));
          },
          label: const Text(Strings.addNewReminder)),
    );
  }

  Future<List<Reminder>> getUserReminders(BuildContext context, StateManager provider) async {
    return await provider.getUserReminders();
  }
}
