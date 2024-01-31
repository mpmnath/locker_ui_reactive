import 'package:flutter/material.dart';

class PickupBoxEmpty extends StatelessWidget {
  final int boxNumber;

  const PickupBoxEmpty(this.boxNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Center(
        child: Text('Box $boxNumber\nEmpty'),
      ),
    );
  }
}