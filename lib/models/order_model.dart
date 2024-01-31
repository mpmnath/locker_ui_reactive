class Order {
  final int orderId;
  final int boxNumber;
  final DateTime expirationTime;

  Order(this.orderId, this.boxNumber, this.expirationTime);

  Order.empty()
      : orderId = 0,
        boxNumber = 0,
        expirationTime = DateTime.now()
            .subtract(const Duration(seconds: 1)); // Set to past time

  bool get isEmpty => orderId == 0;
}