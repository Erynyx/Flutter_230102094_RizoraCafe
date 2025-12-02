import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CartItem {
  final MenuItem menu;
  int quantity;

  CartItem({required this.menu, this.quantity = 1});

  double get totalPrice => menu.price * quantity;
}

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void addToCart(MenuItem menu, int qty) {
    final existing = _items.where((e) => e.menu == menu).toList();

    if (existing.isNotEmpty) {
      existing.first.quantity += qty;
    } else {
      _items.add(CartItem(menu: menu, quantity: qty));
    }
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
