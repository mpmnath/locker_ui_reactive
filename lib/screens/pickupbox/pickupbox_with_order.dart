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
        //border: Border.all(),
        color: Colors.yellow,
        border: Border.all(
          color: Colors.green,
          width: 8,
        ), //Border.all
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(
              5.0,
              5.0,
            ), //Offset
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
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
