import 'package:intl/intl.dart';

import '../../../domain/entity/loan_details.dart';
import '../../../domain/entity/payment_type.dart';
import 'payment_ui.dart';

class LoanCalculationResultUi {
  static final currency = NumberFormat.currency(locale: 'ru_RU', symbol: '₽');

  final LoanDetails loanDetails;
  final List<PaymentUi> payments;
  final String calculationDate;
  final String totalPayment;
  final String totalInterest;

  const LoanCalculationResultUi({
    required this.loanDetails,
    required this.payments,
    required this.calculationDate,
    required this.totalPayment,
    required this.totalInterest,
  });

  String get monthlyPayment {
    if (payments.isEmpty) return '-1';

    return switch (loanDetails.paymentType) {
      PaymentType.annuity => payments[1].totalAmount,
      PaymentType.differentiated => '${payments[1].totalAmount}..${payments.last.totalAmount}',
    };
  }

  String get principal => currency.format(loanDetails.principal);

  String get interest => currency.format(loanDetails.interestRatePerYear);
}
