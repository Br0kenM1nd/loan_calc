import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../flow/loan_calc_presenter.dart';
import '../../../flow/loan_calc_ui_state.dart';
import '../../page/loan_calc_details_page.dart';

class CalculationResultWidget extends StatelessWidget {
  const CalculationResultWidget({super.key});

  static const TextStyle headingStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle descriptionStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoanCalcPresenterImpl());
    return Obx(
      () => switch (c.uiState.value) {
        == LoanCalcUiState.empty =>  SizedBox(
          child: Obx(() => c.isShowBox.value ? const CupertinoActivityIndicator() : SizedBox()),
        ),
        == LoanCalcUiState.error => Text(
            c.inputError.value,
            style: const TextStyle(color: Color(0xFFB00020)),
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
              CupertinoButton(
                onPressed: () => Get.to(() => const LoanCalcDetailsPage()),
                child: const Text('Подробнее'),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        _ => const SizedBox(),
      },
    );
  }
}
