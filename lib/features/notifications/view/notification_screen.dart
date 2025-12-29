import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/devices/get_localization_provider.dart';
import '../controller/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NotificationProvider>().loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final localizationController = getLocalizationController(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        elevation: 0,
        title:  Text(localizationController.getTextValue(
          "NOTIFICATIONS_TITLE",
        )),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.notifications.isEmpty) {
            return const _EmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            itemCount: provider.notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              final isUnread = !notification.isRead;

              return Dismissible(
                key: ValueKey(notification.id),
                direction: DismissDirection.endToStart,
                background: _DeleteBackground(),
                onDismissed: (_) {
                  provider.deleteNotification(notification.id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: isUnread ? const Color(0xffEEF4FF) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // IMPORTANT
                    children: [
                      // Left accent bar
                      Container(
                        width: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isUnread
                              ? theme.primaryColor
                              : Colors.transparent,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Theme(
                          data: theme.copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            onExpansionChanged: (expanded) {
                              if (expanded && isUnread) {
                                provider.markRead(notification.id);
                              }
                            },
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundColor: isUnread
                                  ? theme.primaryColor.withOpacity(0.15)
                                  : Colors.grey.withOpacity(0.15),
                              child: Icon(
                                Icons.notifications,
                                color: isUnread
                                    ? theme.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            title: Text(
                              notification.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight:
                                isUnread ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                notification.createdAt,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Text(
                                  notification.message,
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // child: AnimatedContainer(
                //   duration: const Duration(milliseconds: 250),
                //   decoration: BoxDecoration(
                //     color: isUnread
                //         ? const Color(0xffEEF4FF)
                //         : Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.05),
                //         blurRadius: 10,
                //         offset: const Offset(0, 4),
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     children: [
                //       // Left accent bar
                //       Container(
                //         width: 4,
                //         height: double.infinity,
                //         decoration: BoxDecoration(
                //           color: isUnread
                //               ? theme.primaryColor
                //               : Colors.transparent,
                //           borderRadius: const BorderRadius.horizontal(
                //             left: Radius.circular(16),
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Theme(
                //           data: theme.copyWith(
                //             dividerColor: Colors.transparent,
                //           ),
                //           child: ExpansionTile(
                //             tilePadding: const EdgeInsets.symmetric(
                //               horizontal: 16,
                //               vertical: 10,
                //             ),
                //             onExpansionChanged: (expanded) {
                //               if (expanded && isUnread) {
                //                 provider.markRead(notification.id);
                //               }
                //             },
                //             leading: CircleAvatar(
                //               radius: 22,
                //               backgroundColor: isUnread
                //                   ? theme.primaryColor.withOpacity(0.15)
                //                   : Colors.grey.withOpacity(0.15),
                //               child: Icon(
                //                 Icons.notifications,
                //                 color: isUnread
                //                     ? theme.primaryColor
                //                     : Colors.grey,
                //               ),
                //             ),
                //             title: Text(
                //               notification.title,
                //               style: theme.textTheme.bodyLarge!.copyWith(
                //                 fontWeight: isUnread
                //                     ? FontWeight.w600
                //                     : FontWeight.w400,
                //               ),
                //             ),
                //             subtitle: Padding(
                //               padding: const EdgeInsets.only(top: 4),
                //               child: Text(
                //                 notification.createdAt,
                //                 style: theme.textTheme.bodySmall!
                //                     .copyWith(color: Colors.grey),
                //               ),
                //             ),
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.fromLTRB(
                //                     16, 0, 16, 16),
                //                 child: Text(
                //                   notification.message,
                //                   style: theme.textTheme.bodyMedium!
                //                       .copyWith(height: 1.5),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );
    return SizedBox.expand( // 🔥 VERY IMPORTANT
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 6),
            Text(
              localizationController.getTextValue(
                "DELETE",
              ),
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final localizationController = getLocalizationController(
      context,
      listen: false,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            localizationController.getTextValue(
              "NO_NOTIFICATIONS_TITLE",
            ),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            localizationController.getTextValue(
              "NO_NOTIFICATIONS_SUBTITLE",
            ),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/notification_provider.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<NotificationProvider>().loadNotifications();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Notifications")),
//       body: Consumer<NotificationProvider>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (provider.notifications.isEmpty) {
//             return const Center(child: Text("No Notifications"));
//           }
//
//           return ListView.builder(
//             itemCount: provider.notifications.length,
//             itemBuilder: (context, index) {
//               final notification = provider.notifications[index];
//
//               return Dismissible(
//                 key: ValueKey(notification.id),
//                 direction: DismissDirection.endToStart,
//                 background: Container(
//                   color: Colors.red,
//                   alignment: Alignment.centerRight,
//                   padding: const EdgeInsets.only(right: 20),
//                   child: const Icon(Icons.delete, color: Colors.white),
//                 ),
//                 onDismissed: (_) {
//                   provider.deleteNotification(notification.id);
//                 },
//                 child: Card(
//                   child: ExpansionTile(
//                     onExpansionChanged: (expanded) {
//                       if (expanded && !notification.isRead) {
//                         provider.markRead(notification.id);
//                       }
//                     },
//                     leading: Icon(
//                       notification.isRead
//                           ? Icons.notifications
//                           : Icons.notifications_active,
//                       color:
//                       notification.isRead ? Colors.grey : Colors.blue,
//                     ),
//                     title: Text(notification.title),
//                     subtitle: Text(notification.createdAt),
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Text(notification.message),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
