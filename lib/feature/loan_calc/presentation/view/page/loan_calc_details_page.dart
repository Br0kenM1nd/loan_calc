import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../flow/loan_calc_presenter.dart';
import '../widget/result/payments_schedule_table.dart';

class LoanCalcDetailsPage extends StatelessWidget {
  const LoanCalcDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoanCalcPresenterImpl());
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('График платежей')),
      child: PaymentsScheduleTable(c.payments),
    );
  }
}
