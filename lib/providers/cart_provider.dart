import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(String itemName, double price, String imageUrl) {
    if (itemName.isEmpty || price <= 0 || imageUrl.isEmpty) {
      debugPrint('Invalid item data: $itemName, $price, $imageUrl');
      return;
    }

    final existingItemIndex =
        _cartItems.indexWhere((item) => item['itemName'] == itemName);

    if (existingItemIndex >= 0) {
      _cartItems[existingItemIndex]['quantity']++;
    } else {
      _cartItems.add({
        'itemName': itemName,
        'price': price,
        'quantity': 1,
        'imageUrl': imageUrl,
      });
    }
    debugPrint('Item added to cart: $itemName, $price');
    notifyListeners();
  }

  void removeItem(String itemName) {
    _cartItems.removeWhere((item) => item['itemName'] == itemName);
    notifyListeners();
  }

  void updateQuantity(String itemName, int quantity) {
    final itemIndex =
        _cartItems.indexWhere((item) => item['itemName'] == itemName);
    if (itemIndex >= 0) {
      _cartItems[itemIndex]['quantity'] = quantity;
      if (quantity <= 0) {
        removeItem(itemName);
      }
      notifyListeners();
    }
  }

  double getTotalPrice() {
    return _cartItems.fold(
      0.0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
  }
}
