import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/drawer_app.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).FetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productUser = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProductScreen.routeName),
              icon: Icon(Icons.add))
        ],
      ),
      drawer: DrawerShop(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (cxt, i) => Column(
              children: [
                UserProductItem(
                    id: productUser.items[i].id,
                    title: productUser.items[i].title,
                    urlImage: productUser.items[i].imageUrl),
                Divider()
              ],
            ),
            itemCount: productUser.items.length,
          ),
        ),
      ),
    );
  }
}
