import 'package:flutter/material.dart';

class AdditionalInfoItems extends StatelessWidget {
  final IconData i;
  final String t1;
  final String t2;

  const AdditionalInfoItems({
    super.key,
    required this.i,
    required this.t1,
    required this.t2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          i,
          size: 45,
        ),
        SizedBox(
          height: 13,
        ),
        Text(
          t1,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          t2,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
