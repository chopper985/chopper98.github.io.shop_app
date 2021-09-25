import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/circle.gif',
            image: product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (BuildContext context, product, Widget? child) =>
                IconButton(
                    onPressed: () => product.toggleFavorite(),
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size:20
                    )),
          ),
          trailing: IconButton(
              onPressed: () {
                cart.addCart(product.id, product.title, product.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Added to Your Cart!'),
                    duration: const Duration(seconds: 1),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        cart.undoItem(product.id);
                      },
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart,size: 20)),
        ),
      ),
    );
  }
}
