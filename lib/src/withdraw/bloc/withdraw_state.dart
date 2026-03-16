part of 'withdraw_bloc.dart';

enum WithdrawStatus {
  initial,
  selecting,
  reviewing,
  submitting,
  success,
  failure,
}

class WithdrawState extends Equatable {
  final WithdrawStatus status;
  final String selectedMethod;
  final String displayInfo;
  final String amount;
  final String message;

  const WithdrawState({
    required this.status,
    required this.selectedMethod,
    required this.displayInfo,
    required this.amount,
    required this.message,
  });

  static const WithdrawState initial = WithdrawState(
    status: WithdrawStatus.initial,
    selectedMethod: 'upi',
    displayInfo: 'UPI: user@okhdfcbank',
    amount: '200',
    message: '',
  );

  WithdrawState copyWith({
    WithdrawStatus Function()? status,
    String Function()? selectedMethod,
    String Function()? displayInfo,
    String Function()? amount,
    String Function()? message,
  }) {
    return WithdrawState(
      status: status != null ? status() : this.status,
      selectedMethod: selectedMethod != null
          ? selectedMethod()
          : this.selectedMethod,
      displayInfo: displayInfo != null ? displayInfo() : this.displayInfo,
      amount: amount != null ? amount() : this.amount,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [
    status,
    selectedMethod,
    displayInfo,
    amount,
    message,
  ];
}
