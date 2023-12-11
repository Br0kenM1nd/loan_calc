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
}
