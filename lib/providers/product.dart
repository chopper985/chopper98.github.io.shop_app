import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final dynamic price;
  final String imageUrl;
  bool isFavorite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool oldFavorite) {
    isFavorite = oldFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final oldFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shopapp-f8890-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    try {
      var response = await http.patch(Uri.parse(url),
          body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavValue(oldFavorite);
      }
    } catch (e) {
      _setFavValue(oldFavorite);
    }
  }
}
