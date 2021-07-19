import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

class DioAdapterSpy implements HttpClientAdapter {
  Map<String, dynamic>? jsonToReturn;
  bool shouldReturnError = false;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future? cancelFuture,
  ) {
    final responsePayload = jsonEncode(jsonToReturn ?? {"test": "test"});
    final httpResponse = ResponseBody.fromString(
      responsePayload,
      shouldReturnError ? 401 : 200,
      headers: dioHttpHeadersForResponseBody,
    );
    return Future.value(httpResponse);
  }
}
