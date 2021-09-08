import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final int quantity;
  final double price;
  const CartItem({
    Key? key,
    required this.id,
    required this.title,
    required this.productId,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                    title: Row(
                      children: [
                        Icon(Icons.notifications_active,color: Theme.of(context).errorColor,),
                        SizedBox(width: 10,),
                        Text('Are you sure?',style: TextStyle(color: Theme.of(context).errorColor,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    content: Text('Do you want to remove the item from cart?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text('No')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text('Yes'))
                    ]));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(child: Text('\$$price')))),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
