import 'package:network/src/endpoint.dart';
import 'package:network/src/network_provider/network_provider_interface.dart';
import 'package:network/src/serializable_response.dart';

abstract class RequestHelperInterface {
  Future<T> makeRequest<T>({
    required NetworkProviderInterface networkProvider,
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  });
}
