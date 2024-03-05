import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tasks/core/orders.dart';
import 'package:tasks/screens/terminal_screen/pending_orders_screen.dart';
import 'package:tasks/screens/terminal_screen/pickup_screen.dart';
import 'package:tasks/screens/widgets/pickupbox_widget.dart';

class PickupBoxTerminal extends StatefulWidget {
  const PickupBoxTerminal({super.key});

  @override
  _PickupBoxTerminalState createState() => _PickupBoxTerminalState();
}

class _PickupBoxTerminalState extends State<PickupBoxTerminal> {
  final Orders _orders = Orders();

  @override
  void dispose() {
    _orders.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Up Box Terminal'),
      ),
      body: Container(
        width: size.width,
        height: size.height - 150,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(
            color: Colors.black,
            width: 24.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8, // Assuming 4 columns for 8 pickup boxes
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return PickupBoxWidget(index + 1, _orders);
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PickupTerminalScreen(
                        orders: _orders, orderStream: _orders.orderStream),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: PendingOrdersTerminalScreen(orders: _orders),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simulate assigning an order to a random pickup box
          int orderId = Random().nextInt(500) +
              500; // Generating a random order ID between >=500 and <1000
          _orders.enqueueOrder(orderId);
        },
        tooltip: 'Assign Random Order',
        child: const Icon(Icons.add),
      ),
    );
  }
}
