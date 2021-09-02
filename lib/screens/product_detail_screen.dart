import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  // final String id;
  // final String title;
  // final String imageUrl;
  // final String description;
  const ProductDetailScreen(
      {Key? key,
      // required this.id,
      // required this.title,
      // required this.imageUrl,
      // required this.description
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        title: Text(
          '',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
