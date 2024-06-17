import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'feature/loan_calc/view/page/loan_calc_page.dart';

void main() => runApp(const LoanCalcApp());

class LoanCalcApp extends StatelessWidget {
  const LoanCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetCupertinoApp(
      theme: CupertinoThemeData(),
      home: LoanCalcPage(),
    );
  }
}
