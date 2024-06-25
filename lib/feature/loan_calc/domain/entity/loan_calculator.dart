import 'dart:math';

import '../../../../utils/time_extension.dart';
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
      PaymentType.differentiated => calculateDifferentiatedPayments(loanDetails),
    };
    return LoanCalculationResult(
      loanDetails: loanDetails,
      payments: payments,
      calculationDate: now,
    );
  }

  List<Payment> calculateAnnuityPayments(LoanDetails loanDetails) {
    final monthlyInterestRate = loanDetails.interestRatePerYear / 12 / 100;
    final (principal, loanTermInMonths) = (loanDetails.principal, loanDetails.loanTermInMonths);
    final annuityFactor = (monthlyInterestRate * pow(1 + monthlyInterestRate, loanTermInMonths)) /
        (pow(1 + monthlyInterestRate, loanTermInMonths) - 1);
    final monthlyPayment = principal * annuityFactor;
    var remainingPrincipal = principal;

    final payments = <Payment>[_firstPayment(principal)];

    for (var i = 1; i <= loanTermInMonths; i++) {
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
    final principal = loanDetails.principal;
    final monthlyPrincipal = principal / loanDetails.loanTermInMonths;
    var remainingPrincipal = principal;

    final payments = <Payment>[_firstPayment(principal)];

    for (var i = 1; i <= loanDetails.loanTermInMonths; i++) {
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

  Payment _firstPayment(double principal) => Payment(
        number: 0,
        date: now,
        totalAmount: 0,
        principalAmount: 0,
        interestAmount: 0,
        remainingPrincipal: principal,
      );
}
