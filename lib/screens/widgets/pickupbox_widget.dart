import 'package:flutter/material.dart';
import 'package:tasks/bloc/order_bloc.dart';
import 'package:tasks/models/order_model.dart';
import 'package:tasks/screens/pickupbox/pickupbox_empty.dart';
import 'package:tasks/screens/pickupbox/pickupbox_with_order.dart';

class PickupBoxWidget extends StatelessWidget {
  final int boxNumber;
  final OrderBloc orderBloc;

  const PickupBoxWidget(this.boxNumber, this.orderBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Order>>(
      stream: orderBloc.orderStream as Stream<List<Order>>?,
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