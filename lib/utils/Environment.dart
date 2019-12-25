import 'package:dotenv/dotenv.dart' show load, env;

class Environment {
  static init() => load();

  static String get zomatoKey {
    return env['ZOMATO_API_KEY'];
  }
}