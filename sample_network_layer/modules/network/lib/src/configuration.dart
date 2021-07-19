class Configuration {
  final String baseUrl;
  final int _connectionTimeoutInSeconds;
  final Map<String, dynamic> defaultHeaders;

  int get conectionTimeout => 1000 * _connectionTimeoutInSeconds;

  Configuration({
    required this.baseUrl,
    int connectionTimeoutInSeconds = 30,
    Map<String, dynamic> defaultHeaders = const <String, dynamic>{},
  })  : assert(baseUrl.isNotEmpty),
        this._connectionTimeoutInSeconds = connectionTimeoutInSeconds,
        this.defaultHeaders = defaultHeaders;
}
