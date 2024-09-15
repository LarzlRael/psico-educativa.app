import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(
      fileName: '.env',
    );
  }

  static String serverApi =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
  static String googleMapsApiKey =
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'No está configurado el API_URL';
}
