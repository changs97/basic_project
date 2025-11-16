import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // 예시 API들 (모델 없이 단순 타입으로)
  @GET('/counter')
  Future<int> fetchCounter();

  @POST('/counter/increment')
  Future<int> incrementCounter();
}


