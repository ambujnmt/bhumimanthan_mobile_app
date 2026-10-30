import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils/app_imports.dart';
import 'top_level_notification_services.dart';

class FirebaseServices {
  static final _fcm = FirebaseMessaging.instance;

  static Future<void> startNotificationService() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      carPlay: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('notification permission granted');
      _startNotificationListening();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('notification permission provisional');
      _startNotificationListening();
    } else {
      debugPrint('notification permission denied');
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
    return;
  }

  static Future<String?> getDeviceToken() async {
    try {
      return await _fcm.getToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return '';
  }

  static void _startNotificationListening() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotificationPopup(message);
    });
    debugPrint('in app notification listening started');
  }

  static Future<RemoteMessage?> getInitialMessage() async {
    return _fcm.getInitialMessage();
  }

  static Future<void> printCurrentToken() async {
    final t = await getDeviceToken();
    debugPrint('device token: $t');
  }

  static Future<void> deleteToken() async {
    try {
      await _fcm.deleteToken();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
