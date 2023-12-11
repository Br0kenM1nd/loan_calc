import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/loan_calc_controller.dart';
import '../widget/result/calculation_result_widget.dart';
import '../widget/user_input/calculate_button_widget.dart';
import '../widget/user_input/user_input_group.dart';

class LoanCalcPage extends StatelessWidget {
  const LoanCalcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoanCalcController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор кредитов'),
      ),
      body:  const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInputGroup(),
              SizedBox(height: 16.0),
              CalculationResultWidget(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CalculateButtonWidget(c.calculate),
    );
  }
}
