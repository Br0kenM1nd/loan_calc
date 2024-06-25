class PaymentUi {
  final String number;
  final String date;
  final String totalAmount;
  final String principalAmount;
  final String interestAmount;
  final String remainingPrincipal;

  const PaymentUi({
    required this.number,
    required this.date,
    required this.totalAmount,
    required this.principalAmount,
    required this.interestAmount,
    required this.remainingPrincipal,
  });
}
