import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psico_educativa_app/constants/key_constants.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/services/auth_services.dart'
    as AuthServices;
import 'package:psico_educativa_app/services/services.dart';

enum AuthStatus { checking, noAuthenticated, authenticated }

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
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Aquí deberías integrar tu lógica de autenticación (API, base de datos, etc.)

      final user = await AuthServices.signIn(username, password);
      return saveUserAndToken(user,
          errorMessage: 'Nombre de usuario o contraseña incorrectos');
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error de autenticación: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> renewToken() async {
    try {
      // Aquí deberías integrar tu lógica de autenticación (API, base de datos, etc.)

      final user = await AuthServices.renewToken();

      saveUserAndToken(user, errorMessage: 'Sesion cerrada');

      return state.authenticateStatus == AuthStatus.authenticated;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error de autenticación: ${e.toString()}',
        authenticateStatus: AuthStatus.noAuthenticated,
      );
      return state.authenticateStatus == AuthStatus.authenticated;
    }
  }

  Future<bool> saveUserAndToken(UserApi? user, {String? errorMessage}) async {
    if (user == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
        authenticateStatus: AuthStatus.noAuthenticated,
      );
      return false;
    }
    await keyValueStorageService.setKeyValue<String>(TOKEN, user.accessToken);
    await keyValueStorageService.setKeyValue<int>(ID_USER, user.id);
    state = state.copyWith(
        authenticateStatus: AuthStatus.authenticated,
        isLoading: false,
        user: user);
    return true;
  }

  // Método para manejar el cierre de sesión
  Future<void> logout() async {
    state = AuthState.initial();
    await keyValueStorageService.removeKey('token');
    await keyValueStorageService.removeKey('id_user');
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
    final googleAuth = await AuthServices.signInWithGoogle();
    state = state.copyWith(
        authenticateStatus: AuthStatus.authenticated,
        isLoading: false,
        user: googleAuth);
    return googleAuth == null;
  }
}

/// Estado que representa el proceso de inicio de sesión.
class AuthState {
  final bool isLoading;
  final AuthStatus authenticateStatus;
  final String? errorMessage;
  final UserApi?
      user; // Nueva propiedad que guarda la información del usuario autenticado

  AuthState({
    required this.isLoading,
    required this.authenticateStatus,
    this.errorMessage,
    this.user,
  });

  // Estados iniciales
  factory AuthState.initial() => AuthState(
        isLoading: false,
        authenticateStatus: AuthStatus.checking,
        errorMessage: null,
        user: null,
      );

  AuthState copyWith({
    bool? isLoading,
    AuthStatus? authenticateStatus,
    String? errorMessage,
    UserApi? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      authenticateStatus: authenticateStatus ?? this.authenticateStatus,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}
