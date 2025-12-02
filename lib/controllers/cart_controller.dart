import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CartItem {
  final MenuItem menu;
  int quantity;

  CartItem({
    required this.menu,
    required this.quantity,
  });

  double get totalPrice => menu.price * quantity;
}

class CartController extends ChangeNotifier {
  final List<CartItem> items = [];

  // Tambah ke keranjang (support quantity langsung)
  void addToCart(MenuItem menu, int qty) {
    final index = items.indexWhere((item) => item.menu.name == menu.name);

    if (index != -1) {
      items[index].quantity += qty;
    } else {
      items.add(CartItem(menu: menu, quantity: qty));
    }

    notifyListeners();
  }

  // Hapus item
  void removeFromCart(CartItem item) {
    items.remove(item);
    notifyListeners();
  }

  // Total harga semua item
  double get totalPrice =>
      items.fold(0, (total, item) => total + item.totalPrice);

  // Clear cart
  void clearCart() {
    items.clear();
    notifyListeners();
  }
}
