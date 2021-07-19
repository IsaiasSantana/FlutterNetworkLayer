import 'package:dio/dio.dart';
import 'package:network/src/endpoint.dart';
import 'package:network/src/exceptions/decode_exception.dart';
import 'package:network/src/exceptions/internal_error_exception.dart';
import 'package:network/src/network_provider/network_provider_interface.dart';
import 'package:network/src/serializable_response.dart';

class DioNetworkProvider implements NetworkProviderInterface {
  final Dio _dio;

  DioNetworkProvider({required Dio dio}) : _dio = dio;

  @override
  Future<T> get<T>({
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  }) async {
    return await _send<T>(endpoint, parser);
  }

  Future<T> _send<T>(Endpoint endpoint, SerializableResponse<T> parser) async {
    try {
      final response = await _makeRequestWith(endpoint: endpoint);
      return _parse<T>(response: response, parser: parser);
    } on DioError catch (error) {
      throw _buildNetworkError(error);
    } on Exception {
      rethrow;
    }
  }

  Future<Response<dynamic>> _makeRequestWith(
      {required Endpoint endpoint}) async {
    switch (endpoint.method) {
      case HttpMethod.get:
        {
          return await _makeGetRequest(endpoint: endpoint);
        }
      case HttpMethod.post:
        {
          // TODO: Implement post request
          throw UnimplementedError();
        }
    }
  }

  Future<Response<dynamic>> _makeGetRequest({
    required Endpoint endpoint,
  }) async {
    return _dio.get(
      endpoint.path,
      queryParameters: endpoint.queryParameters,
      options: _createOptionsFrom(endpoint: endpoint),
    );
  }

  Options _createOptionsFrom({required Endpoint endpoint}) {
    return Options(
      headers: _buildHeadersWith(endpoint: endpoint),
      responseType: _responseTypeFrom(contentEncoding: endpoint.encoding),
    );
  }

  Map<String, dynamic> _buildHeadersWith({required Endpoint endpoint}) {
    return <String, dynamic>{
      ..._dio.options.headers,
      ...?endpoint.headers,
    };
  }

  ResponseType _responseTypeFrom({
    required ContentEncoding contentEncoding,
  }) {
    switch (contentEncoding) {
      case ContentEncoding.json:
        return ResponseType.json;
    }
  }

  T _parse<T>({
    required Response<dynamic> response,
    required SerializableResponse<T> parser,
  }) {
    final statusCode = response.statusCode ?? 0;

    if (statusCode >= 200 && statusCode < 400) {
      return _decodeDataToResponse<T>(
        data: response.data,
        parser: parser,
        statusCode: statusCode,
      );
    }

    throw NetworkException(
      errorMessage: response.statusMessage ?? 'unknow error',
      statusCode: response.statusCode,
    );
  }

  T _decodeDataToResponse<T>({
    dynamic data,
    required SerializableResponse<T> parser,
    required int statusCode,
  }) {
    try {
      return parser.decodeFrom(data: data);
    } catch (_) {
      throw DecodeException();
    }
  }

  NetworkException _buildNetworkError(DioError error) {
    if (error.response != null) {
      return NetworkException(
        errorMessage: error.response!.statusMessage ?? '',
        statusCode: error.response!.statusCode,
        data: error.response!.data,
      );
    } else {
      return NetworkException(errorMessage: error.message);
    }
  }
}
