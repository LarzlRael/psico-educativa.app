import 'package:psico_educativa_app/config/environment.dart';
import 'package:riverpod/riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Enum para el estado del servidor
enum ServerStatus {
  online,
  offline,
  connecting,
}

// Provider del SocketNotifier
final socketProvider = StateNotifierProvider<SocketNotifier, SocketState>(
  (ref) => SocketNotifier(),
);

// Notificador de estado del socket
class SocketNotifier extends StateNotifier<SocketState> {
  late IO.Socket _socket;

  SocketNotifier() : super(SocketState(serverStatus: ServerStatus.connecting)) {
    _connect();
  }

  IO.Socket get socket => _socket;

  Future<void> _connect() async {
    /* final token = await _storage.read(key: 'token'); */

    _socket = IO.io(
      Environment.serverApi, // Reemplaza con tu URL de servidor
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableForceNew()
          .setExtraHeaders({
            /* 'Authorization': 'Bearer $token', */
          })
          .build(),
    );

    _socket.on('connect', (_) {
      state =
          state.copyWith(serverStatus: ServerStatus.online, socket: _socket);
    });

    _socket.on('disconnect', (_) {
      state =
          state.copyWith(serverStatus: ServerStatus.offline, socket: _socket);
    });
  }

  void sendMessage(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void disconnect() {
    _socket.disconnect();
  }
}

// Estado del SocketService
class SocketState {
  final ServerStatus serverStatus;
  final IO.Socket? socket;

  SocketState({
    required this.serverStatus,
    this.socket,
  });

  SocketState copyWith({
    ServerStatus? serverStatus,
    IO.Socket? socket,
  }) {
    return SocketState(
      serverStatus: serverStatus ?? this.serverStatus,
      socket: socket ?? this.socket,
    );
  }
}
