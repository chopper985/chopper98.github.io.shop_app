import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/drawer_app.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum checkFavorite { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _selectedFavorites = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    // final productContainer = Provider.of<Products>(context);
    return Scaffold(
      drawer: DrawerShop(),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (checkFavorite selected) {
              setState(() {
                if (selected == checkFavorite.Favorites) {
                  _selectedFavorites = true;
                } else {
                  _selectedFavorites = false;
                }
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Show All'),
                value: checkFavorite.All,
              ),
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: checkFavorite.Favorites,
              )
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) =>
                Badge(child: ch as Widget, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed('/cart-screen'),
            ),
          )
        ],
        // ignore: deprecated_member_use
        title: Text(
          'Shop App',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: ProductGrid(selectedFavorites: _selectedFavorites),
    );
  }
}
