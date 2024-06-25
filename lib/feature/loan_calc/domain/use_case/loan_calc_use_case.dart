import 'package:get/get.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../../presentation/flow/loan_calc_presenter.dart';
import '../entity/loan_calculator.dart';
import '../entity/loan_details.dart';
import '../presenter/loan_calc_presenter.dart';

class LoanCalcUseCase implements UseCase<void, LoanDetails> {

  LoanCalcUseCase();

  @override
  void call({LoanDetails? loanDetails}) {
  final LoanCalcPresenter _presenter = Get.find<LoanCalcPresenterImpl>();
    try {
      if (loanDetails == null) return;
      final validationErrors = loanDetails.validationErrors;
      if (validationErrors.isNotEmpty) {
        _presenter.showError('validationErrors');
        // return Failed(
        //   ValidationException(validationErrors),
        //   StackTrace.current,
        // );
      }

      final result = Success(const LoanCalculator().calculate(loanDetails));
      _presenter.showResult(result.data!);
    } on Exception catch (_) {
      _presenter.showError('calculationError');
    }
  }
}
