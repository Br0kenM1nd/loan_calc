import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/loan_calc_controller.dart';
import '../widget/result/payments_scedule_table.dart';

class LoanCalcDetailsPage extends StatelessWidget {
  const LoanCalcDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoanCalcController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('График платежей'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PaymentsScheduleTable(c.payments),
          ],
        ),
      ),
    );
  }
}
