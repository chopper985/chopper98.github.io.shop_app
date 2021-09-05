import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/order.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return Card(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                  DateFormat('dd MM yyyy hh:mm').format(widget.order.createAt)),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
                height: min(widget.order.product.length * 20 + 20, 180),
                child: ListView(
                  children: widget.order.product
                      .map((e) => Row(
                            children: [
                              Text(
                                e.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text('${e.quantity} x \$${e.price}')
                            ],
                          ))
                      .toList(),
                ),
              )
          ],
        ));
  }
}
