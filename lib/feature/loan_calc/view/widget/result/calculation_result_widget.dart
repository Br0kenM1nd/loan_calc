import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/loan_calc_controller.dart';
import '../../controller/loan_calc_ui_state.dart';
import '../../page/loan_calc_details_page.dart';

class CalculationResultWidget extends StatelessWidget {
  const CalculationResultWidget({Key? key}) : super(key: key);

  static const TextStyle headingStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle descriptionStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoanCalcController>();
    return Obx(
      () => switch (c.uiState.value) {
        == LoanCalcUiState.empty => const SizedBox(),
        == LoanCalcUiState.error => Text(
            c.inputError.value,
            style: const TextStyle(color: Colors.redAccent),
          ),
        == LoanCalcUiState.success => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Результат:', style: headingStyle),
              const Text('Ежемесячный платеж: ', style: descriptionStyle),
              Text(c.monthlyPayment.value, style: headingStyle),
              const Text('Общая сумма выплат: ', style: descriptionStyle),
              Text(c.totalPayment.value, style: headingStyle),
              const Text(
                'Переплата по процентам: ',
                style: descriptionStyle,
              ),
              Text(c.totalInterest.value, style: headingStyle),
              ElevatedButton(
                onPressed: () => Get.to(() => const LoanCalcDetailsPage()),
                child: Text('Подробнее'),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        _ => const SizedBox(),
      },
    );
  }
}
