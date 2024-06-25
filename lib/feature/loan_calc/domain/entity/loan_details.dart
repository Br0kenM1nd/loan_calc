import '../constant/calc_loan_constant.dart';
import 'payment_type.dart';

class LoanDetails {
  final double principal;
  final double interestRatePerYear;
  final int loanTermInMonths;
  final PaymentType paymentType;

  const LoanDetails({
    required this.principal,
    required this.interestRatePerYear,
    required this.loanTermInMonths,
    required this.paymentType,
  });

  Map<String, String> get validationErrors {
    final errors = <String, String>{};
    if (principal <= 0 || principal > LoanCalcConstant.loanAmountMax) {
      errors['loanAmount'] = 'Сумма кредита должна быть в диапазоне\nот 1 до 1 000 000 000';
    }
    if (interestRatePerYear <= 0 ||
        interestRatePerYear > LoanCalcConstant.interestRatePerYearMax) {
      errors['interestRatePerYear'] = 'Процентная ставка должна быть в диапазоне\nот 1 до 100';
    }
    if (loanTermInMonths <= 0 ||
        loanTermInMonths > LoanCalcConstant.loanTermInMonthsMax) {
      errors['loanTermInMonths'] = 'Срок кредита должен быть в диапазоне\nот 1 до 600 месяцев';
    }
    return errors;
  }
}
