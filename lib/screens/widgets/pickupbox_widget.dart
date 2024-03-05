import 'package:flutter/material.dart';
import 'package:tasks/core/orders.dart';
import 'package:tasks/models/order_model.dart';
import 'package:tasks/screens/pickupbox/pickupbox_empty.dart';
import 'package:tasks/screens/pickupbox/pickupbox_with_order.dart';

class PickupBoxWidget extends StatelessWidget {
  final int boxNumber;
  final Orders orders;

  const PickupBoxWidget(this.boxNumber, this.orders, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Order>>(
      stream: orders.orderStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Order> orders = snapshot.data!;
          Order? assignedOrder = orders.firstWhere(
              (order) => order.boxNumber == boxNumber,
              orElse: () => Order.empty());

          if (assignedOrder.isEmpty) {
            return PickupBoxEmpty(boxNumber);
          } else {
            return PickupBoxWithOrder(boxNumber, assignedOrder);
          }
        } else {
          return PickupBoxEmpty(boxNumber);
        }
      },
    );
  }
}
