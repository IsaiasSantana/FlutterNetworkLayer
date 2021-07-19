import 'package:network/network.dart';
import 'package:network/src/serializable_response.dart';

import '../fixtures/response_fixture.dart';

class HttpProviderSpy implements HttpProviderInterface {
  bool requestCalled = false;
  dynamic dataToReturn;

  @override
  Future<T> request<T>({
    required Endpoint endpoint,
    required SerializableResponse<T> parser,
  }) {
    requestCalled = true;
    return dataToReturn ?? ResponseFixture();
  }
}
