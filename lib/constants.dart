import 'package:flutter_dotenv/flutter_dotenv.dart';

const coinAPI_URL = 'https://rest.coinapi.io/v1/exchangerate';
//Use your own API Key
String? apiKey = dotenv.env['apiKey'];
