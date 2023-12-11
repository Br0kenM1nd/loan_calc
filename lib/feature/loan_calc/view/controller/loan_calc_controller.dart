import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/data_state/data_state.dart';
import '../../domain/entity/loan_calculation_result.dart';
import '../../domain/entity/loan_details.dart';
import '../../domain/entity/payment.dart';
import '../../domain/entity/payment_type.dart';
import '../../domain/use_case/loan_calc_use_case.dart';
import '../view_model/loan_calc_view_model.dart';
import 'loan_calc_ui_state.dart';

class LoanCalcController extends GetxController {
  // Входные данные от пользователя
  final loanAmount = TextEditingController();
  final interestRatePerYear = TextEditingController();
  final loanTermInMonths = TextEditingController();
  final paymentType = PaymentType.annuity.obs;

  // Выходные данные
  final monthlyPayment = ''.obs;
  final totalPayment = ''.obs;
  final totalInterest = ''.obs;
  final inputError = ''.obs;

  var interest = .0;
  var principal = .0;
  var payments = <Payment>[];

  // Вспомогательные
  final uiState = LoanCalcUiState.empty.obs;
  final formKey = GlobalKey<FormState>();

  final calcLoanUseCase = const LoanCalcUseCase();

  void calculate() {
    // Первичная валидация гарантирует
    // что к моменту вызова функции parseValues все входные можно будет спарсить
    if (!formKey.currentState!.validate()) return;

    final (loanAmount, interestRatePerYear, loanTermInMonths) = parseValues();

    final loanDetails = LoanDetails(
      principal: loanAmount,
      interestRatePerYear: interestRatePerYear,
      loanTermInMonths: loanTermInMonths,
      paymentType: paymentType.value,
    );

    final result = calcLoanUseCase(loanDetails: loanDetails);

    if (result is DataSuccess) {
      showResult(result.data!);
    } else {
      showError(result.error!.$1.toString());
    }
  }

  void showResult(LoanCalculationResult result) {
    final viewModel = LoanCalcViewModel(result: result);
    monthlyPayment.value = viewModel.monthlyPayment;
    totalPayment.value = viewModel.totalPayment;
    totalInterest.value = viewModel.totalInterest;
    interest = viewModel.interest;
    principal = viewModel.principal;
    payments = result.payments;
    uiState.value = LoanCalcUiState.success;
  }

  void showError(String errorText) {
    inputError.value = errorText;
    uiState.value = LoanCalcUiState.error;
  }

  (double loanAmount, double interestRatePerYear, int loanTermInMonths)
      parseValues() {
    return (
      double.parse(loanAmount.text),
      double.parse(interestRatePerYear.text),
      int.parse(loanTermInMonths.text),
    );
  }
}
