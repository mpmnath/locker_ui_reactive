// order_bloc.dart
import 'dart:async';
import 'dart:collection';

import 'package:tasks/models/order_model.dart';
import 'package:tasks/screens/pickupbox_terminal.dart';

class OrderBloc {
  final _orderController = StreamController<List<Order>>.broadcast();
  final _orderQueueController = StreamController<Queue<int>>.broadcast();
  final List<Order> _assignedOrders = [];
  final Queue<int> _orderQueue = Queue();

  Stream<List<Order>> get orderStream => _orderController.stream;
  Stream<Queue<int>> get orderQueueStream => _orderQueueController.stream;

  OrderBloc() {
    _startExpirationCheck();
  }

  void _startExpirationCheck() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkExpiredOrders();
      _updateTimers();
      _orderQueueController.add(_orderQueue);
    });
  }

  void _checkExpiredOrders() {
    List<Order> expiredOrders = _assignedOrders
        .where((order) => order.expirationTime.isBefore(DateTime.now()))
        .toList();

    for (Order expiredOrder in expiredOrders) {
      _assignedOrders.remove(expiredOrder);
      _orderController.add(List.from(_assignedOrders));
      _tryAssignOrder();
    }
  }

  void enqueueOrder(int orderId) {
    _orderQueue.add(orderId);
    _tryAssignOrder();
  }

  void _tryAssignOrder() {
    for (int boxNumber = 1; boxNumber <= 8; boxNumber++) {
      if (_assignedOrders.every((order) => order.boxNumber != boxNumber) &&
          _orderQueue.isNotEmpty) {
        int orderId = _orderQueue.removeFirst();
        _assignOrderToBox(orderId, boxNumber);
      }
    }
  }

  void _assignOrderToBox(int orderId, int boxNumber) {
    DateTime expirationTime = DateTime.now().add(const Duration(seconds: 30));
    Order assignedOrder = Order(orderId, boxNumber, expirationTime);
    _assignedOrders.add(assignedOrder);
    _orderController.add(List.from(_assignedOrders));
  }

  void _updateTimers() {
    _orderController.add(List.from(_assignedOrders));
  }

  void dispose() {
    _orderController.close();
    _orderQueueController.close();
  }
}
