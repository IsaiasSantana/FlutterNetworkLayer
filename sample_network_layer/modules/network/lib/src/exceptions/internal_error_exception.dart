class NetworkException implements Exception {
  final String errorMessage;
  final int? statusCode;
  final dynamic data;

  NetworkException({
    required this.errorMessage,
    this.statusCode,
    this.data,
  });
}
