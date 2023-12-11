import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/constant/calc_loan_constant.dart';
import '../../controller/loan_calc_controller.dart';
import 'choose_payment_type_widget.dart';
import 'input_field_widget.dart';

class UserInputGroup extends StatelessWidget {
  const UserInputGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoanCalcController>();
    return Form(
      key: c.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputFieldWidget(
            labelText: 'сумма кредита',
            controller: c.loanAmount,
            min: LoanCalcConstant.loanAmountMin,
            max: LoanCalcConstant.loanAmountMax / 100,
          ),
          const SizedBox(height: 16.0),
          InputFieldWidget(
            labelText: 'процентная ставка',
            controller: c.interestRatePerYear,
            min: LoanCalcConstant.interestRatePerYearMin,
            max: LoanCalcConstant.interestRatePerYearMax / 2,
          ),
          const SizedBox(height: 16.0),
          InputFieldWidget(
            labelText: 'срок кредита в месяцах',
            controller: c.loanTermInMonths,
            allowFloat: false,
            min: LoanCalcConstant.loanTermInMonthsMin,
            max: LoanCalcConstant.loanTermInMonthsMax / 10,
          ),
          const SizedBox(height: 24.0),
          Text('Тип ежемесячных платежей', style: TextStyle(fontSize: 20.0)),
          const ChoosePaymentTypeWidget(),
        ],
      ),
    );
  }
}
