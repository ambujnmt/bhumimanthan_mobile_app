import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/app_imports.dart';
import 'package:path/path.dart' as p;

import 'api_headers.dart.dart';

class ApiServices {
  ApiServices._internal();

  static final ApiServices instance = ApiServices._internal();

  factory ApiServices() {
    return instance;
  }

  final http.Client _httpClient = http.Client();

  final testDomain = 'site2demo.in';
  final testSubDomain = '/DomisQuick/api/v1';

  //   final domain = 'greystaruniform.com';
  //   final subDomain = '/api';

  Uri setUri(String endPoint, {Map<String, String>? queries}) {
    return Uri.https(testDomain, '$testSubDomain$endPoint', queries);
    // return Uri.https(domain, '$subDomain$endPoint', queries);
  }

  Future<ApiRes> post(
    final String endPoint, {
    final Map<String, dynamic>? payload,
    final Map<String, String>? customHeaders,
    final Uri? uri,
    final bool showErrorToast = false,
    final http.Client? client,
  }) async {
    try {
      // final lc = Get.find<LanguageController>();

      debugPrint('payload: ${payload.toString()}');

      final finalUri =
          uri ??
          setUri(
            endPoint,
            // queries: {'lang': lc.selectedLanguage.locale.languageCode},
          );

      final res = await (client ?? _httpClient).post(
        finalUri,
        headers: customHeaders ?? ApiHeaders.authHeaders(),
        body: jsonEncode(payload),
      );
      return handleResponse(
        res,
        'post',
        finalUri.toString(),
        showErrorToast: showErrorToast,
      );
    } catch (e) {
      final message = 'Error api calling: ${e.toString()}';
      debugPrint(message);
      if (showErrorToast) AppToast.error(message);
      return ApiRes(code: 0, data: message, success: false);
    }
  }

  Future<ApiRes> put(
    final String endPoint, {
    final Map<String, dynamic>? payload,
    final Map<String, String>? customHeaders,
    final Function(http.Response response)? onError,
    final Uri? uri,
    final bool showErrorToast = false,
    final http.Client? client,
  }) async {
    try {
      // final lc = Get.find<LanguageController>();

      debugPrint('payload: ${payload.toString()}');

      final finalUri =
          uri ??
          setUri(
            endPoint,
            // queries: {'lang': lc.selectedLanguage.locale.languageCode},
          );

      final res = await (client ?? _httpClient).put(
        finalUri,
        headers: customHeaders ?? ApiHeaders.authHeaders(),
        body: jsonEncode(payload),
      );
      return handleResponse(
        res,
        'POST',
        finalUri.toString(),
        showErrorToast: showErrorToast,
      );
    } catch (e) {
      final message = 'Error api calling: ${e.toString()}';
      debugPrint(message);
      if (showErrorToast) AppToast.error(message);
      return ApiRes(code: 0, data: message, success: false);
    }
  }

  Future<ApiRes> delete(
    final String endPoint, {
    final Map<String, dynamic>? payload,
    final Map<String, String>? customHeaders,
    final Uri? uri,
    final bool showErrorToast = false,
    final http.Client? client,
  }) async {
    try {
      // final lc = Get.find<LanguageController>();

      debugPrint('payload: ${payload.toString()}');

      final finalUri =
          uri ??
          setUri(
            endPoint,
            // queries: {'lang': lc.selectedLanguage.locale.languageCode},
          );

      final res = await (client ?? _httpClient).delete(
        finalUri,
        headers: customHeaders ?? ApiHeaders.authHeaders(),
        body: jsonEncode(payload),
      );
      return handleResponse(
        res,
        'DELETE',
        finalUri.toString(),
        showErrorToast: showErrorToast,
      );
    } catch (e) {
      final message = 'Error api calling: ${e.toString()}';
      debugPrint(message);
      if (showErrorToast) AppToast.error(message);
      return ApiRes(code: 0, data: message, success: false);
    }
  }

  Future<ApiRes> get(
    final String endPoint, {
    final Map<String, String>? queries,
    final Map<String, String>? customHeaders,
    final Uri? uri,
    final bool showErrorToast = false,
    final http.Client? client,
  }) async {
    try {
      // final lc = Get.find<LanguageController>();

      debugPrint('queries: ${queries.toString()}');

      final finalUri =
          uri ??
          setUri(
            endPoint,
            queries: {
              // 'lang': lc.selectedLanguage.locale.languageCode,
              ...?queries,
            },
          );
      final res = await (client ?? _httpClient).get(
        finalUri,
        headers: customHeaders ?? ApiHeaders.authHeaders(),
      );
      return handleResponse(
        res,
        'GET',
        finalUri.toString(),
        showErrorToast: showErrorToast,
      );
    } catch (e) {
      final message = 'Error api calling: ${e.toString()}';
      debugPrint(message);
      if (showErrorToast) AppToast.error(message);
      return ApiRes(code: 0, data: message, success: false);
    }
  }

  Future<ApiRes> multipartPost(
    final dynamic endPoint, {
    final Map<String, String?> fields = const {},
    final Map<String, String>? customHeaders,
    final List<MultipartFileItem> files = const [],
    final Function(http.Response response)? onError,
    final Uri? uri,
    final bool showErrorToast = false,
    final void Function(double val)? onProgress,
    final http.Client? client,
  }) async {
    http.Client? requestClient;
    bool shouldCloseClient = false;

    try {
      debugPrint('fields: $fields');

      final finalUri = uri ?? setUri(endPoint);

      // Use provided client or create a new one
      if (client != null) {
        requestClient = client;
        shouldCloseClient = true;
      } else {
        requestClient = _httpClient;
      }

      // Create request
      final request = http.MultipartRequest('POST', finalUri);

      // Add headers
      request.headers.addAll(customHeaders ?? ApiHeaders.authHeaders());

      // Handle fields
      if (fields.isNotEmpty) {
        fields.removeWhere((key, value) => value == null);

        request.fields.addAll(fields.map((k, v) => MapEntry(k, v.toString())));
      }

      // Add files
      if (files.isNotEmpty) {
        final fileSizes = await Future.wait(
          files.map((item) => item.file.length()),
        );

        final totalBytes = fileSizes.fold<int>(0, (sum, size) => sum + size);

        int bytesSent = 0;

        for (int i = 0; i < files.length; i++) {
          final item = files[i];

          final file = item.file;
          final fileLength = fileSizes[i];

          final fileStream = file.openRead();

          final progressStream = fileStream.transform(
            StreamTransformer<List<int>, List<int>>.fromHandlers(
              handleData: (data, sink) {
                bytesSent += data.length;

                final progress = totalBytes == 0 ? 1.0 : bytesSent / totalBytes;

                onProgress?.call(progress);

                sink.add(data);
              },
            ),
          );

          request.files.add(
            http.MultipartFile(
              item.keyName,
              progressStream,
              fileLength,
              filename: p.basename(file.path),
            ),
          );
        }
      }

      // Send request
      final streamedResponse = await requestClient.send(request);

      final response = await http.Response.fromStream(streamedResponse);

      return handleResponse(
        response,
        'multipartPost',
        finalUri.toString(),
        showErrorToast: showErrorToast,
      );
    } catch (e) {
      final message = 'Error api calling: ${e.toString()}';
      debugPrint(message);
      if (showErrorToast) AppToast.error(message);
      return ApiRes(code: 0, data: message, success: false);
    } finally {
      // Only close the client if we created it ourselves.
      if (shouldCloseClient) {
        requestClient?.close();
      }
    }
  }

  ApiRes handleResponse(
    final http.Response response,
    final String method,
    final String api, {
    final Uri? uri,
    final bool showErrorToast = false,
  }) {
    final code = response.statusCode;
    final body = response.body;

    debugPrint('api: ${method.toUpperCase()} $api');

    debugPrint('code: $code');

    debugPrint('body: $body');

    // On success
    if (code >= 200 && code < 300) {
      return ApiRes(code: code, data: _customDecoder(response), success: true);
    }

    // On client error eg. unauthorised
    if (code == 401) {
      if (showErrorToast) {
        showErrorToastWithResponse(response);
      }
      return ApiRes(code: code, data: _customDecoder(response), success: false);
    }

    // On any other error
    if (showErrorToast) {
      showErrorToastWithResponse(response);
    }

    return ApiRes(code: code, data: _customDecoder(response), success: false);
  }

  dynamic _customDecoder(http.Response response) {
    try {
      return jsonDecode(response.body);
    } catch (e) {
      return response;
    }
  }

  void showErrorToastWithResponse(http.Response response) {
    try {
      final json = jsonDecode(response.body);
      var errorMessage = 'Something went wrong.';
      if (json.containsKey('message')) {
        errorMessage = json['message'];
      } else {
        errorMessage =
            (json['errors'] as Map<String, dynamic>).values.first[0] as String;
      }
      AppToast.error(errorMessage);
    } catch (e) {
      AppToast.error('Something went wrong.');
    }
  }
}

class ApiRes {
  final int code;
  final dynamic data;
  final bool success;

  const ApiRes({required this.code, required this.data, required this.success});
}

class MultipartFileItem {
  final String keyName;
  final File file;
  MultipartFileItem({required this.keyName, required this.file});
}
