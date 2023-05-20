import 'package:flutter/material.dart';
import 'package:my_teeth/view/widgets/notifications/empty_notification_widget.dart';
import 'package:my_teeth/view/widgets/notifications/notification_widget.dart';
import '../../../../model/app_notification.dart';
import '../../../constants/strings.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final List<AppNotification> _arrNotifications = [
    // AppNotification(
    //     title: "Notification 1",
    //     description: "Description 1",
    //     type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 2",
    //     description: "Description 2",
    //     type: NotificationTypes.reward),
    // AppNotification(
    //     title: "Notification 3",
    //     description: "Description 3",
    //     type: NotificationTypes.reward),
    // AppNotification(
    //     title: "Notification 4",
    //     description: "Description 4",
    //     type: NotificationTypes.reminder),
    // AppNotification(title: "Notification 5", type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 6",
    //     description: "Description 6",
    //     type: NotificationTypes.reward),
    // AppNotification(
    //     title: "Notification 7",
    //     description: "Description 7",
    //     type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 8",
    //     description: "Description 8",
    //     type: NotificationTypes.reward),
    // AppNotification(title: "Notification 9", type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 10",
    //     description: "Description 10",
    //     type: NotificationTypes.reward),
    // AppNotification(
    //     title: "Notification 11",
    //     description: "Description 11",
    //     type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 12",
    //     description: "Description 12",
    //     type: NotificationTypes.reward),
    // AppNotification(title: "Notification 13", type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 14",
    //     description: "Description 14",
    //     type: NotificationTypes.reward),
    // AppNotification(
    //     title: "Notification 15",
    //     description: "Description 15",
    //     type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 16",
    //     description: "Description 16",
    //     type: NotificationTypes.reward),
    // AppNotification(title: "Notification 17", type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 18",
    //     description: "Description 18",
    //     type: NotificationTypes.reward),
    // AppNotification(
    //     title: "Notification 19",
    //     description: "Description 19",
    //     type: NotificationTypes.reminder),
    // AppNotification(
    //     title: "Notification 20",
    //     description: "Description 20",
    //     type: NotificationTypes.reward),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.notifications),
        elevation: 2,
      ),
      body: _arrNotifications.isEmpty
          ? const EmptyNotificationWidget()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return NotificationWidget(
                    notification: _arrNotifications[index]);
              },
              itemCount: _arrNotifications.length,
            ),
    );
  }
}
