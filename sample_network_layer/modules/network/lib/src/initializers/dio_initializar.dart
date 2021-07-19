import 'package:dio/dio.dart';
import 'package:network/src/configuration.dart';

abstract class DioInitializer {
  static Dio initializeWith({required Configuration configuration}) {
    final dio = _initWith(configuration: configuration);
    return dio;
  }

  static Dio _initWith({required Configuration configuration}) {
    return Dio()
      ..options.baseUrl = configuration.baseUrl
      ..options.connectTimeout = configuration.conectionTimeout
      ..options.headers = configuration.defaultHeaders;
  }
}
