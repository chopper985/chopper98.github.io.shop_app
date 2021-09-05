import 'package:flutter/material.dart';

class DrawerShop extends StatelessWidget {
  const DrawerShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 4,
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(leading: Icon(Icons.shop),title: Text('Shop'),onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },),
           ListTile(leading: Icon(Icons.payment),title: Text('Your Order'),onTap: (){
            Navigator.of(context).pushReplacementNamed('/order-screen');
          },)
        ],
      ),
    );
  }
}
