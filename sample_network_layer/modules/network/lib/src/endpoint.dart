abstract class Endpoint {
  String get path;
  HttpMethod get method;
  ContentEncoding get encoding => ContentEncoding.json;
  Map<String, Object>? get headers => null;
  Map<String, Object>? get parameters => null;
  Map<String, Object>? get queryParameters => null;
}

enum HttpMethod { post, get }

enum ContentEncoding { json }
