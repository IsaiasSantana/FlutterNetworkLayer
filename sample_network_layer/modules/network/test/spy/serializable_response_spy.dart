import 'package:network/network.dart';
import 'package:network/src/serializable_response.dart';

import '../fixtures/response_fixture.dart';

class SerializableResponseSpy implements SerializableResponse<ResponseFixture> {
  bool get isDecodeFromDataCalled => _isDecodeFromDataCalled;
  bool _isDecodeFromDataCalled = false;

  bool shouldReturnError = false;

  @override
  ResponseFixture decodeFrom({required data}) {
    _isDecodeFromDataCalled = true;
    if (shouldReturnError) {
      throw DecodeException();
    }
    return ResponseFixture();
  }
}
