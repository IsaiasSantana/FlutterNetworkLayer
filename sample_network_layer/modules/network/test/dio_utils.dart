import 'package:dio/dio.dart';

import 'spy/dio_adapter_spy.dart';

Dio getDio(DioAdapterSpy dioAdapterSpy) {
  final dio = Dio();
  dio.httpClientAdapter = dioAdapterSpy;
  return dio;
}
