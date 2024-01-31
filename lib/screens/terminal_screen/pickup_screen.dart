import 'package:flutter/material.dart';
import 'package:tasks/bloc/order_bloc.dart';
import 'package:tasks/models/order_model.dart';
import 'package:tasks/screens/widgets/countdown_terminal.dart';

class PickupTerminalScreen extends StatelessWidget {
  final OrderBloc orderBloc;
  const PickupTerminalScreen({super.key, required this.orderBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      //height: 400,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      margin: const EdgeInsets.all(8.0),
      child: StreamBuilder<List<Order>>(
        stream: orderBloc.orderStream as Stream<List<Order>>?,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Order> orders = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ready for pickup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const ListTile(
                    visualDensity: VisualDensity(vertical: -4),
                    contentPadding: EdgeInsets.all(0),
                    leading: Text(
                      'Order',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        'Assigned Box',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    trailing: Text(
                      'Time Left',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      Order order = orders[index];
                      return ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        contentPadding: const EdgeInsets.all(0),
                        leading: Text(
                          '#${order.orderId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        title: Center(
                          child: Text(
                            '${order.boxNumber}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        trailing: CountdownTimer(order.expirationTime),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No Orders Assigned'),
            );
          }
        },
      ),
    );
  }
}
