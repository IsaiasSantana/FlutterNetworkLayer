import 'package:network/src/endpoint.dart';
import 'package:network/src/network_provider/network_provider_interface.dart';
import 'package:network/src/request_helpers/request_helper_interface.dart';
import 'package:network/src/serializable_response.dart';

class GetRequestHelper implements RequestHelperInterface {
  @override
  Future<T> makeRequest<T>({
    required NetworkProviderInterface networkProvider,
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  }) async {
    return networkProvider.get(endpoint: endpoint, parser: parser);
  }
}
