import 'package:flutter_test/flutter_test.dart';
import 'package:network/src/http_provider/http_provider.dart';
import 'package:network/src/http_provider/http_provider_interface.dart';

import 'fixtures/response_fixture.dart';
import 'spy/endpoint_spy.dart';
import 'spy/network_interface_spy.dart';
import 'spy/serializable_response_spy.dart';

void main() {
  final networkProviderSpy = NetworkProviderInterfaceSpy();
  late HttpProviderInterface httpProvider =
      HttpProvider(networkProvider: networkProviderSpy);

  test('test_makeRequest', () async {
    final endpointSpy = EndpointSpy();
    final parser = SerializableResponseSpy();
    final response = await httpProvider.request(
      endpoint: endpointSpy,
      parser: parser,
    );

    expect(response is ResponseFixture, true);
    expect(networkProviderSpy.isGetCalled, true);
    expect(networkProviderSpy.parserPassed == parser, true);
  });
}
