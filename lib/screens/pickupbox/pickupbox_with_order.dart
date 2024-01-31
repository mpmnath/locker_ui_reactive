import 'package:flutter/material.dart';
import 'package:tasks/models/order_model.dart';
import 'package:tasks/screens/widgets/countdown_terminal.dart';

class PickupBoxWithOrder extends StatelessWidget {
  final int boxNumber;
  final Order order;

  const PickupBoxWithOrder(this.boxNumber, this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.yellow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Box $boxNumber'),
          Text('Order ${order.orderId}'),
          CountdownTimer(order.expirationTime),
        ],
      ),
    );
  }
}