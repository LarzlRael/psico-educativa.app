import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psico_educativa_app/constants/key_constants.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/services/auth_services.dart'
    as AuthServices;
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/shared/validations.dart';

enum AuthStatus { checking, noAuthenticated, authenticated }

enum AuthType { emailPassword, google, none }

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  AuthNotifier() : super(AuthState.initial()) {
    checkAuthStatus();
  }

  // Método para manejar el inicio de sesión
  Future<bool> login(String username, String password) async {
    state = state.copyWith(errorMessage: null);

    try {
      // Aquí deberías integrar tu lógica de autenticación (API, base de datos, etc.)

      final user = await AuthServices.signIn(username.trim(), password.trim());
      return saveUserAndToken(user,
          errorMessage: 'Nombre de usuario o contraseña incorrectos');
    } catch (e) {
      state = state.copyWith(
        authenticateStatus: AuthStatus.noAuthenticated,
        errorMessage: 'Error de autenticación: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> register(Map<String, dynamic> body) async {
    state = state.copyWith(errorMessage: null);

    try {
      // Aquí deberías integrar tu lógica de autenticación (API, base de datos, etc.)

      final user = await sendGenericRequest(
        '/auth/register',
        userApiFromJson,
        method: RequestType.post,
        body: body,
      );

      return saveUserAndToken(user,
          errorMessage: 'Hubo un error en el registro');
    } catch (e) {
      state = state.copyWith(
        authenticateStatus: AuthStatus.noAuthenticated,
        errorMessage: 'Error durante el registro: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> forgotPasswordRequest(Map<String, dynamic> body) async {
    state = state.copyWith(errorMessage: null);

    try {
      // Aquí deberías integrar tu lógica de autenticación (API, base de datos, etc.)

      final resp = await Request.sendRequest(
        RequestType.post,
        'auth/forgot-password',
        body: body,
      );
      return validateStatus(resp?.statusCode);
    } catch (e) {
      state = state.copyWith(
        authenticateStatus: AuthStatus.noAuthenticated,
        errorMessage:
            'Error durante el solicitud de cambio de contraseña: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> renewToken() async {
    /* TODO method to verify is google or not */
    try {
      // Aquí deberías integrar tu lógica de autenticación (API, base de datos, etc.)

      final user = await AuthServices.renewToken();

      saveUserAndToken(user, errorMessage: 'Sesion cerrada');

      return state.authenticateStatus == AuthStatus.authenticated;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error de autenticación: ${e.toString()}',
        authenticateStatus: AuthStatus.noAuthenticated,
        authType: AuthType.none,
      );
      return state.authenticateStatus == AuthStatus.authenticated;
    }
  }

  Future<bool> saveUserAndToken(UserApi? user, {String? errorMessage}) async {
    if (user == null) {
      state = state.copyWith(
        errorMessage: errorMessage,
        authenticateStatus: AuthStatus.noAuthenticated,
        authType: AuthType.none,
      );
      return false;
    }
    await keyValueStorageService.setKeyValue<String>(TOKEN, user.accessToken);
    await keyValueStorageService.setKeyValue<int>(ID_USER, user.id);
    state = state.copyWith(
      authenticateStatus: AuthStatus.authenticated,
      user: user,
      authType: AuthType.emailPassword,
    );
    return true;
  }

  // Método para manejar el cierre de sesión
  Future<bool> logout() async {
    print('logout');
    state = state.copyWith(authenticateStatus: AuthStatus.checking, user: null);
    await keyValueStorageService.removeKey(TOKEN);
    await keyValueStorageService.removeKey(ID_USER);
    await AuthServices.signOutFromGoogle();
    

    state = state.copyWith(
      authenticateStatus: AuthStatus.noAuthenticated,
      user: null,
      authType: AuthType.none,
    );
    return true;
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>(TOKEN);

    if (token == null) logout();
    try {
      await renewToken();
    } catch (e) {
      logout();
    }
  }

  Future<bool> loginWithGoogle() async {
    state = state.copyWith(authenticateStatus: AuthStatus.checking);
    final googleAuth = await AuthServices.signInWithGoogle();
    if (googleAuth == null) {
      state = state.copyWith(
        authenticateStatus: AuthStatus.noAuthenticated,
        user: null,
      );
      logout();

      return false;
    }

    state = state.copyWith(
      authenticateStatus: AuthStatus.authenticated,
      user: googleAuth,
    );

    return true;
  }
}

/// Estado que representa el proceso de inicio de sesión.
class AuthState {
  final AuthStatus authenticateStatus;
  final AuthType authType;
  final String? errorMessage;
  final UserApi?
      user; // Nueva propiedad que guarda la información del usuario autenticado

  AuthState({
    required this.authType,
    required this.authenticateStatus,
    this.errorMessage,
    this.user,
  });

  // Estados iniciales
  factory AuthState.initial() => AuthState(
        authenticateStatus: AuthStatus.checking,
        authType: AuthType.none,
        errorMessage: null,
        user: null,
      );

  AuthState copyWith({
    AuthType? authType,
    AuthStatus? authenticateStatus,
    String? errorMessage,
    UserApi? user,
  }) {
    return AuthState(
      authenticateStatus: authenticateStatus ?? this.authenticateStatus,
      authType: authType ?? this.authType,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}
