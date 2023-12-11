import 'package:flutter/material.dart';

class CalculateButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const CalculateButtonWidget(this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Рассчитать сумму ежемесячного платежа'),
    );
  }
}
