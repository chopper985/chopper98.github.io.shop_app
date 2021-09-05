import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/drawer_app.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  // final String id;
  // final String title;
  // final String imageUrl;
  // final String description;
  const ProductDetailScreen({
    Key? key,
    // required this.id,
    // required this.title,
    // required this.imageUrl,
    // required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productDetail =
        Provider.of<Products>(context, listen: false).findID(productId);
    return Scaffold(

      appBar: AppBar(
        // ignore: deprecated_member_use
        title: Text(
          productDetail.title,
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: DrawerShop(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 200,
            width: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/circle.gif',
              image: productDetail.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text('Title: ${productDetail.title}')),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text('Description: ${productDetail.description}')),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text('Price: \$${productDetail.price}'),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blueAccent, Colors.red])),
              child: TextButton(
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Provider.of<Cart>(context,listen: false).addCart(productDetail.id,
                      productDetail.title, productDetail.price);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
