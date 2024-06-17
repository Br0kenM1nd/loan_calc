import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entity/payment_type.dart';
import '../../controller/loan_calc_controller.dart';

class ChoosePaymentTypeWidget extends StatelessWidget {
  const ChoosePaymentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoanCalcController>();
    return Material(
      child: Obx(
        () => Column(
          children: [
            RadioListTile.adaptive(
              groupValue: c.paymentType.value,
              value: PaymentType.annuity,
              onChanged: (value) => c.paymentType.value = value!,
              title: const Text('Аннуитетный'),
            ),
            RadioListTile.adaptive(
              groupValue: c.paymentType.value,
              value: PaymentType.differentiated,
              onChanged: (value) => c.paymentType.value = value!,
              title: const Text('Дифференцированный'),
            ),
          ],
        ),
      ),
    );
  }
}
