import 'package:intl/intl.dart';

import '../../domain/entity/loan_calculation_result.dart';
import '../../domain/entity/payment_type.dart';

class LoanCalcViewModel {
  final LoanCalculationResult result;

  const LoanCalcViewModel({required this.result});

  static final currency = NumberFormat.currency(locale: 'ru_RU', symbol: '₽');

  String get totalPayment => currency.format(result.totalPayment);

  String get totalInterest => currency.format(result.totalInterest);

  String get monthlyPayment {
    if (result.payments.isEmpty) return '-1';

    return switch (result.loanDetails.paymentType) {
      PaymentType.annuity => currency.format(result.payments[1].totalAmount),
      PaymentType.differentiated =>
        '${currency.format(result.payments[1].totalAmount)}..${currency.format(result.payments.last.totalAmount)}',
    };
  }

  double get principal => result.loanDetails.principal;

  double get interest => result.totalInterest;
}
