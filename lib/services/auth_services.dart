import 'package:google_sign_in/google_sign_in.dart';
import 'package:psico_educativa_app/constants/key_constants.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/shared/validations.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);
Future<String> getFCMToken() async {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return await keyValueStorageService.getValue<String>(FCM_TOKEN) ?? '';
}

Future<UserApi?> signIn(String email, String password) async {
  final data = {
    'username': email,
    'password': password,
  };

  final resp =
      await Request.sendRequest(RequestType.post, 'auth/signin', body: data);

  await saveFMCToken();

  /* if (validateStatus(resp!.statusCode)) {
    final user = userApiFromJson(resp.body);
    return user;
  }
  return null; */

  return validateStatus(resp!.statusCode) ? userApiFromJson(resp.body) : null;
}

Future<UserApi?> renewToken() async {
  final resp =
      await Request.sendAuthRequest(RequestType.get, 'auth/renew-token');

  return validateStatus(resp!.statusCode) ? userApiFromJson(resp.body) : null;
}

Future<UserApi?> signInWithGoogle() async {
  final GoogleSignInAccount? account = await googleSignIn.signIn();

  final googleKey = await account?.authentication;
  if (googleKey == null) return null;

  final resp = await Request.sendAuthRequest(
      RequestType.post, 'auth/google-signIn', body: {
    'googleToken': googleKey.idToken,
    'fmcToken': await getFCMToken() 
  });

  return validateStatus(resp!.statusCode) ? userApiFromJson(resp.body) : null;
}

Future<void> signOutFromGoogle() async {
  if (googleSignIn.currentUser != null) {
    // Verificar si hay un usuario activo
    try {
      await googleSignIn.signOut();
      print('User signed out from Google');
    } catch (error) {
      print('Error signing out from Google: $error');
    }
  }
  return;
}

Future<void> saveFMCToken() async {
  final data = {
    'fcmToken': await getFCMToken(),
    'deviceName': "psdf",
  };

  final resp = await Request.sendAuthRequest(
      RequestType.post, 'devices/new-device',
      body: data);

  /* if (validateStatus(resp!.statusCode)) {
    final user = userApiFromJson(resp.body);
    return user;
  }
  return null; */
}
