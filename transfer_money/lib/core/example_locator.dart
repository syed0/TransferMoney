import 'package:clean_framework/clean_framework_defaults.dart';

class ExampleLocator {
  static ExampleLocator instance = ExampleLocator();

  Repository repository = Repository();

  SimpleRestApi api = SimpleRestApi(baseUrl: 'https://192.168.29.25:3000/');
}
