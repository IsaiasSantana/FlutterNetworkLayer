import 'package:network/src/endpoint.dart';
import 'package:network/src/network_provider/network_provider_interface.dart';
import 'package:network/src/serializable_response.dart';

import '../fixtures/response_fixture.dart';

class NetworkProviderInterfaceSpy implements NetworkProviderInterface {
  bool get isGetCalled => _isGetCalled;
  bool _isGetCalled = false;
  SerializableResponse? parserPassed;

  dynamic dataToReturn;

  @override
  Future<T> get<T>({
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  }) {
    _isGetCalled = true;
    parserPassed = parser;
    if (dataToReturn != null) {
      return Future.value(dataToReturn);
    }
    return Future.value(ResponseFixture() as T);
  }
}
