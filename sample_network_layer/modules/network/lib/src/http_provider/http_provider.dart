import 'package:network/src/endpoint.dart';
import 'package:network/src/http_provider/http_provider_interface.dart';
import 'package:network/src/network_provider/network_provider_interface.dart';
import 'package:network/src/request_helpers/request_helper_factory.dart';
import 'package:network/src/serializable_response.dart';

class HttpProvider implements HttpProviderInterface {
  final NetworkProviderInterface networkProvider;

  HttpProvider({
    required this.networkProvider,
  });

  @override
  Future<T> request<T>({
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  }) async {
    try {
      return _makeRequestWith(
        endpoint: endpoint,
        parser: parser,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<T> _makeRequestWith<T>({
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  }) async {
    final requestHelper =
        RequestHelperFactory.createHelperWith(endpoint: endpoint);
    final response = await requestHelper.makeRequest<T>(
      networkProvider: networkProvider,
      endpoint: endpoint,
      parser: parser,
    );
    return response;
  }
}
