import 'package:flutter/material.dart';
import 'package:my_teeth/constants/constants.dart';
import 'package:my_teeth/view/ui/widgets/notifications/empty_notification_widget.dart';
import 'package:my_teeth/view/ui/widgets/notifications/notification_widget.dart';
import '../../../../model/app_notification.dart';


class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final List<AppNotification> _arrNotifications = [
    AppNotification(title: "Notification 1", description: "Description 1", type: NotificationTypes.reminder),
    AppNotification(title: "Notification 2", description: "Description 2", type: NotificationTypes.reward),
    AppNotification(title: "Notification 3", description: "Description 3", type: NotificationTypes.reward),
    AppNotification(title: "Notification 4", description: "Description 4", type: NotificationTypes.reminder),
    AppNotification(title: "Notification 5", type: NotificationTypes.reminder),
    AppNotification(title: "Notification 6", description: "Description 6", type: NotificationTypes.reward),
    AppNotification(title: "Notification 7", description: "Description 7", type: NotificationTypes.reminder),
    AppNotification(title: "Notification 8", description: "Description 8", type: NotificationTypes.reward),
    AppNotification(title: "Notification 9", type: NotificationTypes.reminder),
  ];

  @override
  Widget build(BuildContext context) {
    if (_arrNotifications.isEmpty) {
      return const EmptyNotificationWidget();
    }
    else {
      return ListView.builder(physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return NotificationWidget(notification: _arrNotifications[index]);
        }, itemCount: _arrNotifications.length,);
    }
  }

}