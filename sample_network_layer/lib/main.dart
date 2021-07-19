import 'package:flutter/material.dart';
import 'package:network/network.dart';

// Create the endpoint
class ZipCodeEndpoint extends Endpoint {
  final String zipcode;

  ZipCodeEndpoint({required this.zipcode});

  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get path => '$zipcode/json';
}

class ZipCodeListEndpoint extends Endpoint {
  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get path => 'RS/Porto Alegre/Domingos/json/';
}

class ZipCodeParser implements SerializableResponse<ZipCodeModel> {
  @override
  ZipCodeModel decodeFrom({required dynamic data}) {
    return ZipCodeModel.fromJson(data);
  }
}

class ZipCodeListParser implements SerializableResponse<List<ZipCodeModel>> {
  @override
  List<ZipCodeModel> decodeFrom({required dynamic data}) {
    if (data is List) {
      return data
          .map((e) => ZipCodeModel.fromJson(e))
          .cast<ZipCodeModel>()
          .toList();
    }
    throw DecodeException();
  }
}

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

// This is for sample propose, do not initialize your dependencies this way.
final httpProvider = HttpProviderInitializar.initializeWith(
  configuration: Configuration(baseUrl: 'https://viacep.com.br/ws/'),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<String> zipCodeNotifier = ValueNotifier<String>('');
  Future<void> _searchZipcode(String zipcode) async {
    if (zipcode.length == 8) {
      try {
        final response = await httpProvider.request(
          endpoint: ZipCodeEndpoint(zipcode: zipcode),
          parser: ZipCodeParser(),
        );
        zipCodeNotifier.value = response.toString();
      } catch (error) {
        zipCodeNotifier.value = error.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Search for a brazilian zip code.',
            ),
            TextField(
              onChanged: (zipcode) {
                _searchZipcode(zipcode);
              },
            ),
            ValueListenableBuilder(
              valueListenable: zipCodeNotifier,
              builder: (_, zipcode, __) {
                return Text(
                  'zip code is $zipcode',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _searchZipcode('01001000');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
