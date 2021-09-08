import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String urlImage;
  const UserProductItem({
    Key? key,
    required this.title,
    required this.urlImage,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(urlImage),
      ),
      title: Text(title),
      trailing: Container(
        width: 80,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context,listen: false).deleteProduct(id);
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
