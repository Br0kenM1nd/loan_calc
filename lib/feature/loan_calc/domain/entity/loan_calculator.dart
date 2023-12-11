import 'dart:math';

import 'package:loan_calc/utils/time_extension.dart';

import 'loan_calculation_result.dart';
import 'loan_details.dart';
import 'payment.dart';
import 'payment_type.dart';

// Почитать о использованных алгоритмах можно по ссылке
// https://journal.tinkoff.ru/guide/credit-payment/
class LoanCalculator {
  const LoanCalculator();

  static final now = DateTime.now();

  LoanCalculationResult calculate(LoanDetails loanDetails) {
    final payments = switch (loanDetails.paymentType) {
      PaymentType.annuity => calculateAnnuityPayments(loanDetails),
      PaymentType.differentiated =>
        calculateDifferentiatedPayments(loanDetails),
    };
    return LoanCalculationResult(
      loanDetails: loanDetails,
      payments: payments,
      calculationDate: now,
    );
  }

  List<Payment> calculateAnnuityPayments(LoanDetails loanDetails) {
    final monthlyInterestRate = loanDetails.interestRatePerYear / 12 / 100;
    final annuityFactor = (monthlyInterestRate *
            pow(1 + monthlyInterestRate, loanDetails.loanTermInMonths)) /
        (pow(1 + monthlyInterestRate, loanDetails.loanTermInMonths) - 1);
    final monthlyPayment = loanDetails.principal * annuityFactor;
    double remainingPrincipal = loanDetails.principal;

    List<Payment> payments = [];

    payments = _addFirstPayment(payments, loanDetails.principal);

    for (int i = 1; i <= loanDetails.loanTermInMonths; i++) {
      final interestPayment = remainingPrincipal * monthlyInterestRate;
      final principalPayment = monthlyPayment - interestPayment;
      remainingPrincipal -= principalPayment;

      payments.add(
        Payment(
          number: i,
          date: now.addMonths(i),
          totalAmount: monthlyPayment,
          principalAmount: principalPayment,
          interestAmount: interestPayment,
          remainingPrincipal: remainingPrincipal > 0 ? remainingPrincipal : 0,
        ),
      );
    }

    return payments;
  }

  List<Payment> calculateDifferentiatedPayments(LoanDetails loanDetails) {
    final monthlyInterestRate = loanDetails.interestRatePerYear / 12 / 100;
    final monthlyPrincipal =
        loanDetails.principal / loanDetails.loanTermInMonths;
    double remainingPrincipal = loanDetails.principal;

    List<Payment> payments = [];

    payments = _addFirstPayment(payments, loanDetails.principal);

    for (int i = 1; i <= loanDetails.loanTermInMonths; i++) {
      final interestPayment = remainingPrincipal * monthlyInterestRate;
      remainingPrincipal -= monthlyPrincipal;

      payments.add(
        Payment(
          number: i,
          date: now.addMonths(i),
          totalAmount: monthlyPrincipal + interestPayment,
          principalAmount: monthlyPrincipal,
          interestAmount: interestPayment,
          remainingPrincipal: remainingPrincipal > 0 ? remainingPrincipal : 0,
        ),
      );
    }

    return payments;
  }

  List<Payment> _addFirstPayment(List<Payment> payments, double principal) {
    final firstPayment = Payment(
      number: 0,
      date: now,
      totalAmount: 0,
      principalAmount: 0,
      interestAmount: 0,
      remainingPrincipal: principal,
    );

    return payments..insert(0, firstPayment);
  }
}
