import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/common/models/add_money_model.dart';
import 'package:logger/logger.dart';
import 'package:space_solar_dealer/src/add_money/repo/add_money_repository.dart';

part 'add_money_event.dart';
part 'add_money_state.dart';

class AddMoneyBloc extends Bloc<AddMoneyEvent, AddMoneyState> {
  AddMoneyBloc({required AddMoneyRepository repository})
    : _repository = repository,
      super(AddMoneyState.initial) {
    on<InitializeAddMoney>(_onInitialize);
    on<SelectQuickAmount>(_onSelectQuickAmount);
    on<UpdateAmount>(_onUpdateAmount);
    on<UpdatePromoCode>(_onUpdatePromoCode);
    on<ApplyPromo>(_onApplyPromo);
    on<ProceedToPay>(_onProceedToPay);
    on<ResetAddMoneyMessage>(_onReset);
  }

  final AddMoneyRepository _repository;
  final _log = Logger();

  Future<void> _onInitialize(
    InitializeAddMoney event,
    Emitter<AddMoneyState> emit,
  ) async {
    _log.d('AddMoneyBloc::_onInitialize::Initializing add money');
    try {
      emit(state.copyWith(status: () => AddMoneyStatus.loading));
      final promos = await _repository.getPromos();
      emit(
        state.copyWith(
          status: () => AddMoneyStatus.loaded,
          promos: () => promos,
          message: () => 'Add money initialized successfully',
        ),
      );
    } catch (e) {
      _log.e('AddMoneyBloc::_onInitialize::Error: $e');
      emit(
        state.copyWith(
          status: () => AddMoneyStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  void _onSelectQuickAmount(
    SelectQuickAmount event,
    Emitter<AddMoneyState> emit,
  ) {
    final cleanAmount = event.amount.replaceAll('₹', '');
    emit(
      state.copyWith(
        selectedAmount: () => event.amount,
        amount: () => cleanAmount,
      ),
    );
  }

  void _onUpdateAmount(UpdateAmount event, Emitter<AddMoneyState> emit) {
    emit(state.copyWith(amount: () => event.amount));
  }

  void _onUpdatePromoCode(UpdatePromoCode event, Emitter<AddMoneyState> emit) {
    emit(state.copyWith(promoCode: () => event.promoCode));
  }

  void _onApplyPromo(ApplyPromo event, Emitter<AddMoneyState> emit) {
    // For now, just log. In real app, validate promo
    _log.d('AddMoneyBloc::_onApplyPromo::Applied promo: ${state.promoCode}');
    emit(state.copyWith(message: () => 'Promo applied successfully'));
  }

  Future<void> _onProceedToPay(
    ProceedToPay event,
    Emitter<AddMoneyState> emit,
  ) async {
    _log.d('AddMoneyBloc::_onProceedToPay::Proceeding to pay');
    try {
      emit(
        state.copyWith(
          status: () => AddMoneyStatus.submitting,
          message: () => '',
        ),
      );
      await _repository.proceedToPay(
        amount: state.amount,
        promoCode: state.promoCode,
      );
      emit(
        state.copyWith(
          status: () => AddMoneyStatus.success,
          message: () => 'Payment initiated successfully.',
        ),
      );
    } catch (e) {
      _log.e('AddMoneyBloc::_onProceedToPay::Error: $e');
      emit(
        state.copyWith(
          status: () => AddMoneyStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  void _onReset(ResetAddMoneyMessage event, Emitter<AddMoneyState> emit) {
    emit(state.copyWith(message: () => ''));
  }
}
