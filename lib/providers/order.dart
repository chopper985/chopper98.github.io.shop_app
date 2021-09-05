import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> product;
  final DateTime createAt;
  OrderItem({
    required this.id,
    required this.amount,
    required this.product,
    required this.createAt,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _item = [];

  List<OrderItem> get item {
    return [..._item];
  }

  void addOrder(List<CartItem> product, double total) {
    _item.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            product: product,
            createAt: DateTime.now()));
  }
}
