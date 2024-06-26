import 'package:get/get.dart';

import '../../domain/entity/loan_calculation_result.dart';
import '../data/mapper/loan_calculation_result_ui_mapper.dart';
import '../data/model/loan_calculation_result_ui.dart';
import '../data/model/payment_ui.dart';
import 'loan_calc_ui_state.dart';

class LoanCalcPresenterImpl extends GetxController {
  // Выходные данные
  final monthlyPayment = ''.obs;
  final totalPayment = ''.obs;
  final totalInterest = ''.obs;
  final inputError = ''.obs;

  final isShowBox = false.obs;

  List<PaymentUi> payments = <PaymentUi>[];

  // Вспомогательные
  final uiState = LoanCalcUiState.empty.obs;

  void showResult(LoanCalculationResult result) {
    isShowBox.value = true;
    final ui = LoanCalculationResultUiMapper.fromEntity(result);
    _setUiData(ui);
    uiState.value = LoanCalcUiState.success;
  }

  void _setUiData(LoanCalculationResultUi ui) {
    monthlyPayment.value = ui.monthlyPayment;
    totalPayment.value = ui.totalPayment;
    totalInterest.value = ui.totalInterest;
    payments = ui.payments;
  }

  void showError(String errorText) {
    inputError.value = errorText;
    uiState.value = LoanCalcUiState.error;
  }
}