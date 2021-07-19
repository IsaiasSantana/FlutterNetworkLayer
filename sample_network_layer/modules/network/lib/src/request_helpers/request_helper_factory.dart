import 'package:network/src/endpoint.dart';
import 'package:network/src/request_helpers/get_quest_helper.dart';
import 'package:network/src/request_helpers/request_helper_interface.dart';

class RequestHelperFactory {
  static RequestHelperInterface createHelperWith({required Endpoint endpoint}) {
    switch (endpoint.method) {
      case HttpMethod.get:
        {
          return _createGetRequestHelper();
        }
      case HttpMethod.post:
        throw UnimplementedError();
    }
  }

  static RequestHelperInterface _createGetRequestHelper() {
    return GetRequestHelper();
  }
}
