import 'package:network/src/endpoint.dart';
import 'package:network/src/serializable_response.dart';

abstract class NetworkProviderInterface {
  Future<T> get<T>({
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  });
}
