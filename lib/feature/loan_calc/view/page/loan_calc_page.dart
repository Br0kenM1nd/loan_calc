import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/loan_calc_controller.dart';
import '../widget/result/calculation_result_widget.dart';
import '../widget/user_input/calculate_button_widget.dart';
import '../widget/user_input/user_input_group.dart';

class LoanCalcPage extends StatelessWidget {
  const LoanCalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoanCalcController());
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Калькулятор кредитов')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserInputGroup(),
              // const SizedBox(height: 16.0),
              const CalculationResultWidget(),
              // const Spacer(),
              CalculateButtonWidget(c.calculate),
            ],
          ),
        ),
      ),
    );
  }
}
