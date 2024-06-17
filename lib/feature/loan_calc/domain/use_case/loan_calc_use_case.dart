import 'package:flutter/foundation.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../constant/calc_loan_constant.dart';
import '../entity/loan_calculation_result.dart';
import '../entity/loan_calculator.dart';
import '../entity/loan_details.dart';
import '../exception/validation_exception.dart';

class LoanCalcUseCase implements UseCase<DataState<LoanCalculationResult>, LoanDetails> {
  const LoanCalcUseCase();

  @override
  DataState<LoanCalculationResult> call({LoanDetails? loanDetails}) {
    final validationErrors = validateLoanDetails(loanDetails);
    if (validationErrors.isNotEmpty) {
      return DataFailed(
        ValidationException(validationErrors),
        StackTrace.current,
      );
    }

    try {
      return DataSuccess(const LoanCalculator().calculate(loanDetails!));
    } catch (e) {
      return DataFailed(e, StackTrace.current);
    }
  }

  @visibleForTesting
  Map<String, String> validateLoanDetails(LoanDetails? details) {
    final errors = <String, String>{};
    if (details == null) {
      errors['general'] = 'No LoanDetails provided';
      return errors;
    }
    if (details.principal <= 0 || details.principal > LoanCalcConstant.loanAmountMax) {
      errors['loanAmount'] = 'Сумма кредита должна быть в диапазоне\nот 1 до 1 000 000 000';
    }
    if (details.interestRatePerYear <= 0 ||
        details.interestRatePerYear > LoanCalcConstant.interestRatePerYearMax) {
      errors['interestRatePerYear'] = 'Процентная ставка должна быть в диапазоне\nот 1 до 100';
    }
    if (details.loanTermInMonths <= 0 ||
        details.loanTermInMonths > LoanCalcConstant.loanTermInMonthsMax) {
      errors['loanTermInMonths'] = 'Срок кредита должен быть в диапазоне\nот 1 до 600 месяцев';
    }
    return errors;
  }
}
