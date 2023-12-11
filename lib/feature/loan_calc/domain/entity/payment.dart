class Payment {
  final int number; 
  final DateTime date; 
  final double totalAmount; 
  final double principalAmount; 
  final double interestAmount; 
  final double remainingPrincipal; 

  Payment({
    required this.number,
    required this.date,
    required this.totalAmount,
    required this.principalAmount,
    required this.interestAmount,
    required this.remainingPrincipal,
  });
}
