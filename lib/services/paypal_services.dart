// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

// import '../utils/app_imports.dart';

// class PaypalScreen extends StatelessWidget {
//   final List<dynamic> transactions;
//   final Function onCancel;
//   final Function(Map data) onSuccess;
//   final Function(Map data) onError;
//   const PaypalScreen({
//     super.key,
//     required this.transactions,
//     required this.onSuccess,
//     required this.onCancel,
//     required this.onError,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PaypalCheckoutView(
//       sandboxMode: true,
//       clientId: dotenv.env['clientId']!,
//       secretKey: dotenv.env['secretKey']!,
//       loadingIndicator: AppLoader.widget(),
//       transactions: transactions,
//       note: "Contact us for any questions on your order.",
//       onSuccess: onSuccess,
//       onCancel: onError,
//       onError: onCancel,
//     );
//   }
// }
