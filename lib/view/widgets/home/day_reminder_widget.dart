import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/constants/strings.dart';
import 'package:provider/provider.dart';
import '../../../controller/state_manager.dart';
import '../../../model/reminder/reminder.dart';

class DayReminderWidget extends StatelessWidget {
  final Reminder reminder;

  const DayReminderWidget({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(reminder.title ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            CheckboxListTile(
                title: Text(DateFormat('hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(reminder.time ?? 0))),
                value: reminder.isCompleted,
                onChanged: (value) {
                  Provider.of<StateManager>(context, listen: false).changeReminderStatus(reminder);
                }),
            const SizedBox(height: 8),
            Text(reminder.description == null || reminder.description!.isEmpty
                ? Strings.noDescription
                : reminder.description!),
          ],
        ),
      ),
    );
  }
}
