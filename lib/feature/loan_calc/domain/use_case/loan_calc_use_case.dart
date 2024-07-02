import 'package:get/get.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../../presentation/flow/loan_calc_presenter.dart';
import '../entity/loan_calculator.dart';
import '../entity/loan_details.dart';

class LoanCalcUseCase implements UseCase<void, LoanDetails> {
  LoanCalcUseCase();

  @override
  void call({LoanDetails? loanDetails}) {
    final presenter = Get.find<LoanCalcPresenterImpl>();
    try {
      if (loanDetails == null) return;
      final validationErrors = loanDetails.validationErrors;
      if (validationErrors.isNotEmpty) {
        presenter.showError('validationErrors');
      }
      final result = Success(const LoanCalculator().calculate(loanDetails));
      presenter.showResult(result.data!);
    } on Exception catch (e) {
      presenter.showError(e.toString());
    }
  }
}
