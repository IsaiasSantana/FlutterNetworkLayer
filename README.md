# FlutterNetworkLayer
Sample how we can create an abstract network layer with Flutter.

## Usage
First, we need to create our **HttpProvider** client:
```dart
final httpProvider = HttpProviderInitializer.initializeWith(
  configuration: Configuration(baseUrl: 'https://viacep.com.br/ws/'),
);
```

Before to start a request, we need to define an **Endpoint**, which contains all necessary to make a request:
```dart
class ZipCodeEndpoint extends Endpoint {
  final String zipcode;

  ZipCodeEndpoint({required this.zipcode});

  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get path => '$zipcode/json';
}
```
The base endpoint class has others optional parameters.

With that, define your **model** and **Parser** object to decode the response:

```dart
class ZipCodeModel {
  final String cep;
  final String localidade;
  final String logradouro;

  ZipCodeModel({
    required this.cep,
    required this.localidade,
    required this.logradouro,
  });

  factory ZipCodeModel.fromJson(Map<String, dynamic> json) {
    return ZipCodeModel(
      cep: json['cep'],
      localidade: json['localidade'],
      logradouro: json['logradouro'],
    );
  }

  @override
  String toString() {
    return """
    {
      zipCode: $cep,
      Address: $localidade - $logradouro
    }
    """;
  }
}
```

Sample parser
```dart
class ZipCodeParser implements SerializableResponse<ZipCodeModel> {
  @override
  ZipCodeModel decodeFrom({required dynamic data}) {
    return ZipCodeModel.fromJson(data);
  }
}
```

## Making a request
```dart
try {
 final myModel = await httpProvider.request(
   endpoint: ZipCodeEndpoint(zipcode: zipcode),
   parser: ZipCodeParser(),
 );
 print(myModel);
} catch (error) {
 print(error)
}
```
