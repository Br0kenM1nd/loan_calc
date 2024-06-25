import '../entity/loan_calculation_result.dart';

abstract interface class LoanCalcPresenter {
  void showResult(LoanCalculationResult result);

  void showError(String errorText);
}