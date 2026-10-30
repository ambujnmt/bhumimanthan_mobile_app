import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../app_routes/app_pages.dart';
import '../utils/app_imports.dart';
import 'models/fcm_data_model.dart';

final notificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationServices {
  static final fcm = FirebaseMessaging.instance;

  static Future<void> initializeNotificationPlugin() async {
    final androidInitSetting = const AndroidInitializationSettings(
      'ic_notification_icon',
      // '@mipmap/ic_launcher',
    );

    final iosSettings = DarwinInitializationSettings();

    final settings = InitializationSettings(
      android: androidInitSetting,
      iOS: iosSettings,
    );
    await notificationsPlugin.initialize(
      settings: settings,
      onDidReceiveBackgroundNotificationResponse: notificationTap,
      onDidReceiveNotificationResponse: notificationTap,
    );
    debugPrint('notification plugin initialized');
  }

  static Future<void> enableIOSForegroundNotifications() async {
    await fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> handleTapWhenInBackgroundOrKilled() async {
    final details = await notificationsPlugin.getNotificationAppLaunchDetails();

    if (details?.didNotificationLaunchApp != true) return;

    if (details?.notificationResponse != null) {
      notificationTap(details!.notificationResponse!);
    }
  }

  // Handle notification tap
  static void notificationTap(NotificationResponse notificationResponse) {
    final String payload = notificationResponse.payload!;

    debugPrint('Notification tapped, payload: $payload');

    final json = jsonDecode(payload);
    final data = FcmDataModel.fromJson(json);
    notificationTapRoute(route: data.route, referenceId: data.referenceId);
  }
}

class NotificationRoutes {
  static const String message = 'message';
  static const String notification = 'notification';
  static const String bookingDetails = 'booking_details';
  static const String none = 'none';
}

void notificationTapRoute({String? route, String? referenceId}) {
  debugPrint(
    'notification tap route: $route\nnotification tap referenceId: $referenceId',
  );
  if ((route ?? '').isEmpty) return;
  final exists = AppPages.pages.any((page) => page.name == route);

  if (!exists) {
    return;
  }

  Get.toNamed(route!, arguments: {'id': referenceId}, preventDuplicates: false);
}
