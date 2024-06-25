import 'package:flutter/material.dart';

import '../../../data/model/payment_ui.dart';

class PaymentsScheduleTable extends StatelessWidget {
  final List<PaymentUi> payments;

  const PaymentsScheduleTable(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('№')),
              DataColumn(label: Text('Дата')),
              DataColumn(label: Text('Сумма платежа')),
              DataColumn(label: Text('Платеж по основному долгу')),
              DataColumn(label: Text('Платеж по процентам')),
              DataColumn(label: Text('Остаток долга')),
            ],
            rows: payments.map((payment) {
              return DataRow(
                cells: [
                  DataCell(Text(payment.number)),
                  DataCell(Text(payment.date)),
                  DataCell(Text(payment.totalAmount)),
                  DataCell(Text(payment.principalAmount)),
                  DataCell(Text(payment.interestAmount)),
                  DataCell(Text(payment.remainingPrincipal)),
                ],
              );
            }).toList(growable: false),
          ),
        ),
      ),
    );
  }
}
