import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:tasks/core/orders.dart';

class PendingOrdersTerminalScreen extends StatelessWidget {
  final Orders orders;
  const PendingOrdersTerminalScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            Expanded(
              child: StreamBuilder(
                stream: orders.orderQueueStream,
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
            ),
          ],
        ),
      ),
    );
  }
}
