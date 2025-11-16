import 'package:basic_project/base/network/base_response.dart';

Future<T> runApi<T extends BaseResponseModel>(Future<T> api) async {
  final result = await api;
  final r = result;
  if (r.result == true) {
    return result;
  } else {
    throw Exception(r.code);
  }
}


