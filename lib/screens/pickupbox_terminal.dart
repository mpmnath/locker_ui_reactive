import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tasks/bloc/order_bloc.dart';
import 'package:tasks/screens/terminal_screen/pending_orders_screen.dart';
import 'package:tasks/screens/terminal_screen/pickup_screen.dart';
import 'package:tasks/screens/widgets/pickupbox_widget.dart';

class PickupBoxTerminal extends StatefulWidget {
  const PickupBoxTerminal({super.key});

  @override
  _PickupBoxTerminalState createState() => _PickupBoxTerminalState();
}

class _PickupBoxTerminalState extends State<PickupBoxTerminal> {
  final OrderBloc _orderBloc = OrderBloc();

  @override
  void dispose() {
    _orderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Up Box Terminal'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height / 2,
        child: Row(
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Assuming 4 columns for 8 pickup boxes
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return PickupBoxWidget(index + 1, _orderBloc);
                },
              ),
            ),
            PickupTerminalScreen(orderBloc: _orderBloc),
            PendingOrdersTerminalScreen(orderBloc: _orderBloc),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simulate assigning an order to a random pickup box
          int orderId = Random().nextInt(500) +
              500; // Generating a random order ID between >=500 and <1000
          _orderBloc.enqueueOrder(orderId);
        },
        tooltip: 'Assign Random Order',
        child: const Icon(Icons.add),
      ),
    );
  }
}
