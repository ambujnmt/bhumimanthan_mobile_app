import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
import '../utils/app_imports.dart';
import 'models/fcm_data_model.dart';
import 'notificaion_services.dart';

//show notification popup
@pragma('vm:entry-point')
Future<void> showNotificationPopup(RemoteMessage message) async {
  debugPrint('fcm message received: ${message.data}');
  // final payload = jsonDecode();
  final data = FcmDataModel.fromJson(message.data);

  // StyleInformation? style;
  // final imgUrl =
  //     message.notification?.android?.imageUrl ??
  //     message.notification?.apple?.imageUrl ??
  //     '';
  // if (imgUrl.isNotEmpty) {
  //   final imagePath = await _downloadAndSaveImage(imgUrl);
  //   style = BigPictureStyleInformation(FilePathAndroidBitmap(imagePath));
  // }
  //Prepare notification
  NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'priority_channel_id',
      'Priority Channel',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      color: AppColors.primary,
      // icon: '@drawable/ic_launcher',
      // styleInformation: style,
    ),
  );
  // bool canShow = true;
  // if (data.route == AppRoutes.requestChatScreen) {
  //   try {
  //     canShow =
  //         Get.find<RequestChatScreenController>(
  //           tag: data.referenceId,
  //         ).requestId !=
  //         data.referenceId;
  //   } catch (e) {
  //     //exception
  //   }
  // }

  // if (!canShow) return;
  //show notification
  _showNotification(
    // id: data.id,
    title: data.title,
    // title: message.notification?.title ?? 'New Notification',
    body: data.body,
    // body: message.notification?.body ?? 'You have a new notification',
    notificationDetails: notificationDetails,
    payload: message.data,
  );
}

@pragma('vm:entry-point')
Future<void> _showNotification({
  int? id,
  required String title,
  required String body,
  required NotificationDetails notificationDetails,
  required Map<String, dynamic> payload,
}) async {
  try {
    await notificationsPlugin.show(
      id: id ?? 0,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: jsonEncode(payload),
    );
  } catch (e) {
    debugPrint('error is: $e');
  }
}

// Future<String> _downloadAndSaveImage(String url) async {
//   if (url.isEmpty) return '';
//   final directory = await getTemporaryDirectory();

//   final fileName = 'notification_${DateTime.now().millisecondsSinceEpoch}.jpg';

//   final filePath = '${directory.path}/$fileName';

//   final response = await http.get(Uri.parse(url));

//   final file = File(filePath);
//   await file.writeAsBytes(response.bodyBytes);

//   return filePath;
// }
