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
    return Stack(
      children: [
        ActionChip(
          avatar : const SizedBox.shrink(),
          label: Text(DateFormat('hh:mm a')
              .format(DateTime.fromMillisecondsSinceEpoch(reminder.time ?? 0))),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          onPressed: () {
            onPressed?.call();
          },
        ),
        Positioned(
          top: 8,
          left: 8,
          bottom: 8,
          child: GestureDetector(
              onTap: () {
                onAvatarPressed?.call();
              },
              child: Icon(Icons.edit_outlined, size: 18, color: Theme.of(context).colorScheme.primary)
          ),
        ),
      ],
    );
  }
}
