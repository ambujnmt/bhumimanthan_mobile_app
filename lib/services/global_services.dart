import 'package:intl/intl.dart';

import '../utils/app_imports.dart';

void closeKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> waitForSec(int sec) async {
  return await Future.delayed(Duration(seconds: sec));
}

Future<void> waitForMilliSec(int milliSec) async {
  return await Future.delayed(Duration(milliseconds: milliSec));
}

Color fromHex(String hexCode, {double? opacity}) {
  // print('ccc: ' + hexCode);
  if (hexCode.isEmpty) return transparent;
  hexCode = hexCode.replaceAll('#', '');
  if (hexCode.length == 6) {
    hexCode = 'FF$hexCode'; // add alpha value if missing
  }
  return Color(int.parse('0x$hexCode')).withValues(alpha: opacity ?? 1);
}

String formatPrice(dynamic value, {int decimalDigits = 2}) {
  if (value == null) return '0';

  final number = num.tryParse(value.toString()) ?? 0;

  final formatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '',
    decimalDigits: decimalDigits,
  );

  return '₹${formatter.format(number).trim()}';
}

String firstCap(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String formatDate(DateTime dateTime) {
  return DateFormat('MMM dd, yyyy').format(dateTime);
}

String formatDateTime(String value) {
  try {
    final parsedDate = DateTime.parse(value);

    final time = DateFormat('h:mma').format(parsedDate); // 1:13PM
    final date = DateFormat('d MMM yyyy').format(parsedDate); // 23 Mar 2026

    return '$time • $date';
  } catch (e) {
    return '';
  }
}

double scrollProgressOpacity(
  ScrollController controller, {
  double maxOffset = 20,
}) {
  if (!controller.hasClients) return 0;

  final offset = controller.positions
      .map((position) => position.pixels)
      .fold<double>(0, (max, value) => value > max ? value : max);

  return (offset / maxOffset).clamp(0.0, 1.0);
}

T? findController<T>() {
  if (Get.isRegistered<T>()) {
    return Get.find<T>();
  }
  debugPrint('controller not registered.');
  return null;
}
