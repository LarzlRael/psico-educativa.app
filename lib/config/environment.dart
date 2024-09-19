import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:psico_educativa_app/config/firebase_remote_config.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(
      fileName: '.env',
    );
  }

  final remoteConfig = FirebaseRemoteConfigService();

  /* static String serverApi =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL'; */
  String get serverApi {
    return remoteConfig.getAPirUrl; // Aquí ya puedes acceder a remoteConfig
  }

  static String googleMapsApiKey =
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'No está configurado el API_URL';
}
