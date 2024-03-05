import 'package:flutter/material.dart';

class PickupBoxEmpty extends StatelessWidget {
  final int boxNumber;

  const PickupBoxEmpty(this.boxNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ), //Border.all
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              5.0,
              5.0,
            ), //Offset
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: Center(
        child: Text('Box $boxNumber\nEmpty'),
      ),
    );
  }
}
