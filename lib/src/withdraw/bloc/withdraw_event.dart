part of 'withdraw_bloc.dart';

sealed class WithdrawEvent extends Equatable {
  const WithdrawEvent();

  @override
  List<Object> get props => [];
}

class SelectWithdrawMethod extends WithdrawEvent {
  final String method;
  final String displayInfo;

  const SelectWithdrawMethod({required this.method, required this.displayInfo});

  @override
  List<Object> get props => [method, displayInfo];
}

class UpdateWithdrawAmount extends WithdrawEvent {
  final String amount;

  const UpdateWithdrawAmount({required this.amount});

  @override
  List<Object> get props => [amount];
}

class RedeemWithdraw extends WithdrawEvent {
  const RedeemWithdraw();
}

class EditWithdraw extends WithdrawEvent {
  const EditWithdraw();
}

class ConfirmWithdraw extends WithdrawEvent {
  const ConfirmWithdraw();
}

class ResetWithdrawMessage extends WithdrawEvent {
  const ResetWithdrawMessage();
}
