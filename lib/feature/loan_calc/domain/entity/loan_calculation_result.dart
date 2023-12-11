import 'loan_details.dart';
import 'payment.dart';

class LoanCalculationResult {
  final LoanDetails loanDetails;
  final List<Payment> payments;
  final DateTime calculationDate;

  const LoanCalculationResult({
    required this.loanDetails,
    required this.payments,
    required this.calculationDate,
  });

  double get totalPayment =>
      payments.fold(0, (sum, payment) => sum + payment.totalAmount);

  double get totalInterest =>
      payments.fold(0, (sum, payment) => sum + payment.interestAmount);
}
