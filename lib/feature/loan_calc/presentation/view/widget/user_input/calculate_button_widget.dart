import 'package:flutter/cupertino.dart';

class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CalculateButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: const Text('Рассчитать сумму ежемесячного платежа'),
    );
  }
}
