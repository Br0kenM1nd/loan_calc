import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entity/payment.dart';
import '../../view_model/loan_calc_view_model.dart';

class PaymentsScheduleTable extends StatelessWidget {
  final List<Payment> payments;

  const PaymentsScheduleTable(this.payments, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = LoanCalcViewModel.currency;

    return SingleChildScrollView(
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
          return DataRow(cells: [
            DataCell(Text(payment.number.toString())),
            DataCell(Text(DateFormat('dd.MM.yyyy').format(payment.date))),
            DataCell(Text(currency.format(payment.totalAmount))),
            DataCell(Text(currency.format(payment.principalAmount))),
            DataCell(Text(currency.format(payment.interestAmount))),
            DataCell(Text(currency.format(payment.remainingPrincipal))),
          ]);
        }).toList(),
      ),
    );
  }
}
