import 'package:intl/intl.dart';

import '../../../domain/entity/loan_calculation_result.dart';
import '../../../domain/entity/payment.dart';
import '../model/loan_calculation_result_ui.dart';
import '../model/payment_ui.dart';

abstract class LoanCalculationResultUiMapper {
  static final currency = NumberFormat.currency(locale: 'ru_RU', symbol: '₽');

  static LoanCalculationResultUi fromEntity(LoanCalculationResult result) {
    return LoanCalculationResultUi(
      loanDetails: result.loanDetails,
      payments: _fromEntities(result.payments),
      calculationDate: DateFormat('dd.MM.yyyy').format(result.calculationDate),
      totalPayment: currency.format(result.totalPayment),
      totalInterest: currency.format(result.totalInterest),
    );
  }

  static List<PaymentUi> _fromEntities(List<Payment> payments) {
    return payments.map((payment) => PaymentUi(
        number: payment.number.toString(),
        date: DateFormat('dd.MM.yyyy').format(payment.date),
        totalAmount: currency.format(payment.totalAmount),
        principalAmount: currency.format(payment.principalAmount),
        interestAmount: currency.format(payment.interestAmount),
        remainingPrincipal: currency.format(payment.remainingPrincipal),
      )).toList(growable: false);
  }
}