import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:space_solar_dealer/src/withdraw/repo/withdraw_repository.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  WithdrawBloc({required WithdrawRepository repository})
    : _repository = repository,
      super(WithdrawState.initial) {
    on<SelectWithdrawMethod>(_onSelectMethod);
    on<UpdateWithdrawAmount>(_onUpdateAmount);
    on<RedeemWithdraw>(_onRedeem);
    on<EditWithdraw>(_onEdit);
    on<ConfirmWithdraw>(_onConfirm);
    on<ResetWithdrawMessage>(_onReset);
  }

  final WithdrawRepository _repository;
  final _log = Logger();

  void _onSelectMethod(
    SelectWithdrawMethod event,
    Emitter<WithdrawState> emit,
  ) {
    emit(
      state.copyWith(
        selectedMethod: () => event.method,
        displayInfo: () => event.displayInfo,
      ),
    );
  }

  void _onUpdateAmount(
    UpdateWithdrawAmount event,
    Emitter<WithdrawState> emit,
  ) {
    emit(state.copyWith(amount: () => event.amount));
  }

  void _onRedeem(RedeemWithdraw event, Emitter<WithdrawState> emit) {
    emit(state.copyWith(status: () => WithdrawStatus.reviewing));
  }

  void _onEdit(EditWithdraw event, Emitter<WithdrawState> emit) {
    emit(state.copyWith(status: () => WithdrawStatus.selecting));
  }

  Future<void> _onConfirm(
    ConfirmWithdraw event,
    Emitter<WithdrawState> emit,
  ) async {
    _log.d('WithdrawBloc::_onConfirm::Confirming withdraw');
    try {
      emit(
        state.copyWith(
          status: () => WithdrawStatus.submitting,
          message: () => '',
        ),
      );
      await _repository.withdraw(
        method: state.selectedMethod,
        amount: state.amount,
      );
      emit(
        state.copyWith(
          status: () => WithdrawStatus.success,
          message: () => 'Withdraw request submitted successfully.',
        ),
      );
    } catch (e) {
      _log.e('WithdrawBloc::_onConfirm::Error: $e');
      emit(
        state.copyWith(
          status: () => WithdrawStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  void _onReset(ResetWithdrawMessage event, Emitter<WithdrawState> emit) {
    emit(state.copyWith(message: () => ''));
  }
}
