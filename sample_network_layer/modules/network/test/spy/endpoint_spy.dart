import 'package:network/network.dart';

class EndpointSpy implements Endpoint {
  bool isMethodCalled = false;
  bool isPathCalled = false;
  bool isEncodingCalled = false;
  bool isHeadersCalled = false;
  bool isParametersCalled = false;
  bool isQueryParametersCalled = false;

  @override
  HttpMethod get method {
    isMethodCalled = true;
    return HttpMethod.get;
  }

  @override
  String get path {
    isPathCalled = true;
    return '';
  }

  @override
  ContentEncoding get encoding {
    isEncodingCalled = true;
    return ContentEncoding.json;
  }

  @override
  Map<String, Object>? get headers {
    isHeadersCalled = true;
    return null;
  }

  @override
  Map<String, Object>? get parameters {
    isParametersCalled = true;
    return null;
  }

  @override
  Map<String, Object>? get queryParameters {
    isQueryParametersCalled = true;
    return null;
  }
}
