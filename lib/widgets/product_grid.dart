import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

// ignore: camel_case_types
class ProductGrid extends StatelessWidget {
  final bool selectedFavorites;

  const ProductGrid({Key? key,required this.selectedFavorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> products = selectedFavorites ? productsData.filterFavorites() : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 3 / 2),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(
              // id: products[index].id,
              // title: products[index].title,
              // imageUrl: products[index].imageUrl,
              )),
      itemCount: products.length,
    );
  }
}
