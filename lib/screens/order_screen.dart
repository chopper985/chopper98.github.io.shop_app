import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/drawer_app.dart';
import 'package:shop_app/providers/order.dart' show Order;
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _ordersFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Order>(context, listen: false).fecthAndSetOrder();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ignore: deprecated_member_use
          title: Text(
            'Your Order',
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        drawer: DrawerShop(),
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Consumer<Order>(
                    builder: (ctx, orderData, child) => ListView.builder(
                          itemBuilder: (ctx, i) =>
                              OrderItem(order: orderData.item[i]),
                          itemCount: orderData.item.length,
                        ));
              }
            }));
  }
}
