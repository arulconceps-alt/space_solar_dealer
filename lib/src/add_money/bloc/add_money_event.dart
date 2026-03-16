part of 'add_money_bloc.dart';

sealed class AddMoneyEvent extends Equatable {
  const AddMoneyEvent();

  @override
  List<Object> get props => [];
}

class InitializeAddMoney extends AddMoneyEvent {
  const InitializeAddMoney();
}

class SelectQuickAmount extends AddMoneyEvent {
  final String amount;

  const SelectQuickAmount({required this.amount});

  @override
  List<Object> get props => [amount];
}

class UpdateAmount extends AddMoneyEvent {
  final String amount;

  const UpdateAmount({required this.amount});

  @override
  List<Object> get props => [amount];
}

class UpdatePromoCode extends AddMoneyEvent {
  final String promoCode;

  const UpdatePromoCode({required this.promoCode});

  @override
  List<Object> get props => [promoCode];
}

class ApplyPromo extends AddMoneyEvent {
  const ApplyPromo();
}

class ProceedToPay extends AddMoneyEvent {
  const ProceedToPay();
}

class ResetAddMoneyMessage extends AddMoneyEvent {
  const ResetAddMoneyMessage();
}
