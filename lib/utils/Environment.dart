import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future init() => DotEnv().load();

  static String get zomatoKey {
    return DotEnv().env['ZOMATO_API_KEY'];
  }
}