import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printCurlCommand(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('Response for ${response.requestOptions.uri}\n ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('Error for ${err.requestOptions.uri}\n ${err.response?.data}');
    super.onError(err, handler);
  }

  void _printCurlCommand(RequestOptions options) {
    final curlCommand = _generateCurlCommand(options);
    // ignore: avoid_print
    print('cURL Command:\n$curlCommand');
  }

  String _generateCurlCommand(RequestOptions options) {
    var curlCmd = 'curl';
    curlCmd += ' -X ${options.method}';
    options.headers.forEach((key, value) {
      curlCmd += " -H '$key: $value'";
    });
    final String data = jsonEncode(options.data);
    if (data.isNotEmpty && data != '{}') {
      curlCmd += " -d '$data'";
    }
    curlCmd += ' ${options.uri}';
    return curlCmd;
  }
}


