import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/drawer_app.dart';
import 'package:shop_app/providers/order.dart' show Order;
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        title: Text(
          'Your Order',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: DrawerShop(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(order: orderData.item[i]),
        itemCount: orderData.item.length,
      ),
    );
  }
}
