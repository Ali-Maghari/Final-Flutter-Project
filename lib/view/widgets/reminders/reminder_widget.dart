import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/model/reminder/reminder.dart';

class ReminderItem extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onAvatarPressed;
  final Reminder reminder;

  const ReminderItem({super.key, required this.reminder, this.onPressed, this.onAvatarPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: GestureDetector(
        onTap: () {
          onAvatarPressed?.call();
        },
        child: const Icon(Icons.edit_outlined)
      ),
      label: Text(DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(reminder.time!))),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: () {
        onPressed?.call();
      },
    );
  }
}
