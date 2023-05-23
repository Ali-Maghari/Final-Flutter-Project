import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/constants/strings.dart';
import 'package:my_teeth/controller/state_manager.dart';
import 'package:my_teeth/model/reminder/reminder.dart';
import 'package:provider/provider.dart';


class ReminderDetails extends StatelessWidget {
  final Reminder reminder;

  const ReminderDetails({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: InkWell(
              splashColor: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                await Provider.of<StateManager>(context, listen: false).deleteReminder(context, reminder);
              },
              child: Tooltip(
                message: Strings.deleteReminder,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.primary, size: 22),),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(Strings.reminderDetails, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 40),
          Text(Strings.title, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(reminder.title ?? '', style: TextStyle(color: Theme.of(context).colorScheme.outline)),
          const SizedBox(height: 20),
          Text(Strings.description, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(reminder.description ?? '', style: TextStyle(color: Theme.of(context).colorScheme.outline)),
          const SizedBox(height: 20),
          Text(Strings.reminderTime, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(reminder.time ?? 0)), style: TextStyle(color: Theme.of(context).colorScheme.outline)),
        ],
      ),
    );
  }
}
