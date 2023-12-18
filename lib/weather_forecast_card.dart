import 'package:flutter/material.dart';

class Forecastcard extends StatelessWidget {
  final String time;
  final IconData ic;
  final double Temp;
  const Forecastcard({super.key,required this.time, required this.ic, required this.Temp,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Icon(
                ic,
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                (Temp - 273.15).toStringAsFixed(2)+"°C",
                style: TextStyle(fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ),
    );
  }
}