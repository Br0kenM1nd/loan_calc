import 'package:flutter/cupertino.dart';

class CalculateButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const CalculateButtonWidget(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: const Text('Рассчитать сумму ежемесячного платежа'),
    );
  }
}
