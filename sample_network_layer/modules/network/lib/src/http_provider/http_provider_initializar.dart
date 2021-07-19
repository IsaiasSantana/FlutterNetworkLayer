import 'package:network/src/configuration.dart';
import 'package:network/src/http_provider/http_provider.dart';
import 'package:network/src/http_provider/http_provider_interface.dart';
import 'package:network/src/initializers/dio_initializar.dart';
import 'package:network/src/network_provider/dio_network_provider.dart';

abstract class HttpProviderInitializar {
  static HttpProviderInterface initializeWith({
    required Configuration configuration,
  }) {
    final dio = DioInitializer.initializeWith(configuration: configuration);
    final networkProvider = DioNetworkProvider(dio: dio);
    final httpProvider = HttpProvider(networkProvider: networkProvider);
    return httpProvider;
  }
}
