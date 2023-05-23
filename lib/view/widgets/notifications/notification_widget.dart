import 'package:flutter/material.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/model/app_notification.dart';

class NotificationWidget extends StatelessWidget {
  final AppNotification notification;

  const NotificationWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          notification.type == NotificationType.reminder
              ? CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    size: 20,
                  ))
              : CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  child: Icon(
                    Icons.card_giftcard_outlined,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    size: 20,
                  ),
                ),
          const SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                notification.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (notification.description != null)
                Text(
                  notification.description ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
