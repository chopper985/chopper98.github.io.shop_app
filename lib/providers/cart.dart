import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final dynamic quantity;
  final dynamic price;

  CartItem(
    this.id,
    this.title,
    this.quantity,
    this.price,
  );
}

class Cart with ChangeNotifier {
  // ignore: unused_field
  Map<String, CartItem>? _item = {};

  Map<String, CartItem> get item {
    return {..._item!};
  }

  double get totalPrice {
    double total = 0;
    _item!.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }
  dynamic get itemCount {
    return _item!.length;
  }

  void removeItem(String productId) {
    _item!.remove(productId);
    notifyListeners();
  }

  void addCart(String productId, String title, dynamic price) {
    if (_item!.containsKey(productId)) {
      _item!.update(
          productId,
          (value) => CartItem(
              value.id, value.title, (value.quantity + 1), value.price));
    } else {
      _item!.putIfAbsent(productId,
          () => CartItem(DateTime.now().toString(), title, 1, price));
    }
    notifyListeners();
  }

  void undoItem(String productID) {
    if (!_item!.containsKey(productID)) {
      return;
    }
    if (_item![productID]!.quantity > 1) {
      _item!.update(
          productID,
          (value) =>
              CartItem(value.id, value.title, value.quantity - 1, value.price));
    } else {
      _item!.remove(productID);
    }
    notifyListeners();
  }

  void clearCart() {
    _item = {};
    notifyListeners();
  }
}
