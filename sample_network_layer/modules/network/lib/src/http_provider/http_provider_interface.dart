import 'package:network/src/endpoint.dart';
import 'package:network/src/serializable_response.dart';

abstract class HttpProviderInterface {
  Future<T> request<T>({
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  });
}
