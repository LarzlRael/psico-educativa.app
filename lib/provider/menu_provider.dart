import 'package:flutter_riverpod/flutter_riverpod.dart';

// El StateNotifier controla el estado de la selección
class MenuController extends StateNotifier<int> {
  MenuController() : super(0); // Estado inicial, el índice 0

  // Método para cambiar el índice seleccionado
  void selectItem(int index) => state = index;
}

final menuProvider = StateNotifierProvider<MenuController, int>((ref) {
  return MenuController();
});
