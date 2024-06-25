import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../domain/entity/loan_details.dart';
import '../../domain/entity/payment_type.dart';
import '../../domain/use_case/loan_calc_use_case.dart';

class LoanCalcController extends GetxController {
  // Входные данные от пользователя
  final principal = TextEditingController();
  final interestRatePerYear = TextEditingController();
  final loanTermInMonths = TextEditingController();
  final paymentType = PaymentType.annuity.obs;

  // Вспомогательные
  final formKey = GlobalKey<FormState>();

  final calcLoanUseCase = LoanCalcUseCase();

  bool isValidInput() => formKey.currentState!.validate();

  void calculate() {
    if (!isValidInput()) return;
    calculateLoan(parseValues());
  }

  void calculateLoan(
      ({
        double principal,
        double interestRatePerYear,
        int loanTermInMonths,
      }) values) {
    final loanDetails = LoanDetails(
      principal: values.principal,
      interestRatePerYear: values.interestRatePerYear,
      loanTermInMonths: values.loanTermInMonths,
      paymentType: paymentType.value,
    );

    calcLoanUseCase(loanDetails: loanDetails);
  }

  ({double principal, double interestRatePerYear, int loanTermInMonths}) parseValues() => (
        principal: double.parse(principal.text),
        interestRatePerYear: double.parse(interestRatePerYear.text),
        loanTermInMonths: int.parse(loanTermInMonths.text),
      );
}
