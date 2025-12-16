import 'package:flutter/material.dart';

import '../model/notification_model.dart';

import 'notification_controller.dart';

class NotificationProvider extends ChangeNotifier {
  List<AppNotification> notifications = [];
  int unreadCount = 0;
  bool isLoading = false;

  Future<void> loadNotifications() async {
    isLoading = true;
    notifyListeners();

    notifications = await NotificationService.fetchNotifications();
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadUnreadCount() async {
    unreadCount = await NotificationService.getUnreadCount();
    notifyListeners();
  }

  Future<void> markRead(String id) async {
    // 1️⃣ Update local state immediately
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = AppNotification(
        id: notifications[index].id,
        title: notifications[index].title,
        message: notifications[index].message,
        isRead: true, //  update locally
        createdAt: notifications[index].createdAt,
      );
      notifyListeners(); //  UI updates instantly
    }

    // Call API in background
    await NotificationService.markAsRead([id]);

    // Update count
    loadUnreadCount();
  }


  // Future<void> markRead(String id) async {
  //   await NotificationService.markAsRead([id]);
  //   loadUnreadCount();
  // }

  Future<void> deleteNotification(String id) async {
    await NotificationService.deleteNotification([id]);
    notifications.removeWhere((n) => n.id == id);
    loadUnreadCount();
    notifyListeners();
  }
}
