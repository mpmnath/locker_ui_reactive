
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tasks/bloc/order_bloc.dart';

class PendingOrdersTerminalScreen extends StatelessWidget {
  final OrderBloc orderBloc;
  const PendingOrdersTerminalScreen({super.key, required this.orderBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pending Orders',
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
            StreamBuilder(
              stream: orderBloc.orderQueueStream,
              builder: (contex, snapshot) {
                if (snapshot.hasData) {
                  Queue<int> pendingOrders = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: pendingOrders.length,
                    itemBuilder: (context, index) {
                      int orderId = pendingOrders.elementAt(index);
                      return ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        contentPadding: const EdgeInsets.all(0),
                        leading: Text(
                          '#$orderId',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        title: const Center(
                          child: Text(
                            'Pending',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        trailing: const Text(
                          '--:--',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Orders Assigned'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}