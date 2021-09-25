import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      // ignore: deprecated_member_use
      appBar: AppBar(
        title: Text(
          'My Cart',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: cart.item.length,
                  itemBuilder: (ctx, i) => CartItem(
                      id: cart.item.values.toList()[i].id,
                      title: cart.item.values.toList()[i].title,
                      productId: cart.item.keys.toList()[i],
                      quantity: cart.item.values.toList()[i].quantity,
                      price: cart.item.values.toList()[i].price))),
          SizedBox(
            height: 10,
          ),
          Card(
            margin: const EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.orange,
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [Colors.blue, Colors.green, Colors.pink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  width: 100,
                  child: OrderButton(cart: cart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : TextButton(
            child: Text(
              'ORDER NOW',
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            onPressed: (widget.cart.totalPrice <= 0 || _isLoading == true)
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Order>(context, listen: false).addOrder(
                        widget.cart.item.values.toList(),
                        widget.cart.totalPrice);
                    setState(() {
                      _isLoading = false;
                    });
                    widget.cart.clearCart();
                  },
          );
  }
}
