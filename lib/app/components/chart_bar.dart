import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double porcentage;

  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.porcentage,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
              value.toStringAsFixed(2),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 60,
                width: 10,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                  ),
                  color: const Color.fromARGB(255, 148, 146, 146),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: porcentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 59, 126, 120),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
