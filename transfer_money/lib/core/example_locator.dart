import 'package:clean_framework/clean_framework_defaults.dart';

class ExampleLocator {
  static ExampleLocator instance = ExampleLocator();

  Repository repository = Repository();

  SimpleRestApi api = SimpleRestApi(baseUrl: 'http://192.168.29.246:3000/');
}
