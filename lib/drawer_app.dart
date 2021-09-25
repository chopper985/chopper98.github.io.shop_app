import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class DrawerShop extends StatelessWidget {
  const DrawerShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 4,
      child: Column(
        children: [
          AppBar(
            // ignore: deprecated_member_use
            title: Text('Hello Friend!',style: Theme.of(context).textTheme.subtitle1,),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(leading: Icon(Icons.shop),title: Text('Shop'),onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },),
           ListTile(leading: Icon(Icons.payment),title: Text('Your Order'),onTap: (){
            Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
          },),
          ListTile(leading: Icon(Icons.edit),title: Text('Manager Products'),onTap: (){
            Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
          },)
        ],
      ),
    );
  }
}
