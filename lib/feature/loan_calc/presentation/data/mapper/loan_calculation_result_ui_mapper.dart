import 'package:intl/intl.dart';

import '../../../domain/entity/loan_calculation_result.dart';
import '../../../domain/entity/payment.dart';
import '../model/loan_calculation_result_ui.dart';
import '../model/payment_ui.dart';

abstract class LoanCalculationResultUiMapper {
  static LoanCalculationResultUi fromEntity(LoanCalculationResult result) {
    return LoanCalculationResultUi(
      loanDetails: result.loanDetails,
      payments: _fromEntities(result.payments),
      calculationDate: DateFormat('dd.MM.yyyy').format(result.calculationDate),
      totalPayment: result.totalPayment.toString(),
      totalInterest: result.totalInterest.toString(),
    );
  }

  static List<PaymentUi> _fromEntities(List<Payment> payments) {
    return payments.map((payment) => PaymentUi(
        number: payment.number.toString(),
        date: DateFormat('dd.MM.yyyy').format(payment.date),
        totalAmount: payment.totalAmount.toString(),
        principalAmount: payment.principalAmount.toString(),
        interestAmount: payment.interestAmount.toString(),
        remainingPrincipal: payment.remainingPrincipal.toString(),
      )).toList(growable: false);
  }
}