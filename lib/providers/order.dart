import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final dynamic amount;
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

  Future<void> fecthAndSetOrder() async {
    final url =
        'https://shopapp-f8890-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
    try {
      final List<OrderItem> loaddedOrder = [];
      var response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((orderId, orderData) {
        loaddedOrder.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            product: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                    item['id'], item['title'], item['quantity'], item['price']))
                .toList(),
            createAt: DateTime.parse(orderData['createAt'])));
        _item = loaddedOrder.reversed.toList();
        notifyListeners();
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    final url =
        'https://shopapp-f8890-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
    final timestamp = DateTime.now();
    try {
      var response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'products': products
                .map((pd) => {
                      'id': pd.id,
                      'title': pd.title,
                      'quantity': pd.quantity,
                      'price': pd.price
                    })
                .toList(),
            'createAt': timestamp.toIso8601String()
          }));
      _item.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              product: products,
              createAt: timestamp));
      notifyListeners();
    } catch (e) {}
  }
}
