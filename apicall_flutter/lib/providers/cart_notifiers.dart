import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/product.dart';
import '../data/cart_item.dart';

class CartNotifier extends Notifier<List<CartItem>> {

  @override
  List<CartItem> build() => []; // carrello inizialmente vuoto

  void add(Product product) {
    // se il prodotto è già nel carrello aumenta la quantità
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final updated = state[index].copyWith(quantity: state[index].quantity + 1);
      state = [
        ...state.sublist(0, index),
        updated,
        ...state.sublist(index + 1),
      ];
    } else {
      // altrimenti aggiungilo
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }
  void increment(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index < 0) return;
    final updated = state[index].copyWith(quantity: state[index].quantity + 1);
    state = [
      ...state.sublist(0, index),
      updated,
      ...state.sublist(index + 1),
    ];
  }
  void clear() {
    state = [];
  }

  void decrement(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index < 0) return;
    // se quantità è 1 e decrementi, rimuove il prodotto
    if (state[index].quantity == 1) {
      remove(product);
      return;
    }
    final updated = state[index].copyWith(quantity: state[index].quantity - 1);
    state = [
      ...state.sublist(0, index),
      updated,
      ...state.sublist(index + 1),
    ];
  }

  void remove(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  int get totalItems => state.fold(0, (sum, item) => sum + item.quantity);
}

final cartNotifierProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);