import 'package:flutter_test/flutter_test.dart';

import 'package:network/src/network_provider/dio_network_provider.dart';

import 'dio_utils.dart';
import 'fixtures/response_fixture.dart';
import 'spy/dio_adapter_spy.dart';
import 'spy/endpoint_spy.dart';
import 'spy/serializable_response_spy.dart';

void main() {
  DioAdapterSpy dioAdapterSpy = DioAdapterSpy();

  late DioNetworkProvider dioNetworkProvider =
      DioNetworkProvider(dio: getDio(dioAdapterSpy));

  tearDown(() {
    dioAdapterSpy.shouldReturnError = false;
  });

  test('test_get_shouldReturnResponse', () async {
    final endpointSpy = EndpointSpy();
    final parserSpy = SerializableResponseSpy();
    final response = await dioNetworkProvider.get(
      endpoint: endpointSpy,
      parser: parserSpy,
    );

    expect(response is ResponseFixture, true);
    expect(parserSpy.isDecodeFromDataCalled, true);
    expect(endpointSpy.isMethodCalled, true);
    expect(endpointSpy.isPathCalled, true);
    expect(endpointSpy.isEncodingCalled, true);
    expect(endpointSpy.isParametersCalled, false);
    expect(endpointSpy.isQueryParametersCalled, true);
    expect(endpointSpy.isHeadersCalled, true);
  });

  test('test_get_shouldReturnException', () async {
    final endpointSpy = EndpointSpy();
    final parserSpy = SerializableResponseSpy();
    dioAdapterSpy.shouldReturnError = true;

    expectLater(
      dioNetworkProvider.get(
        endpoint: endpointSpy,
        parser: parserSpy,
      ),
      throwsException,
    );
  });
}
