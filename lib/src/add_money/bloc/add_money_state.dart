part of 'add_money_bloc.dart';

enum AddMoneyStatus { initial, loading, loaded, submitting, success, failure }

class AddMoneyState extends Equatable {
  final AddMoneyStatus status;
  final String selectedAmount;
  final String amount;
  final String promoCode;
  final List<String> quickAmounts;
  final List<PromoModel> promos;
  final String message;

  const AddMoneyState({
    required this.status,
    required this.selectedAmount,
    required this.amount,
    required this.promoCode,
    required this.quickAmounts,
    required this.promos,
    required this.message,
  });

  static const AddMoneyState initial = AddMoneyState(
    status: AddMoneyStatus.initial,
    selectedAmount: '',
    amount: '',
    promoCode: '',
    quickAmounts: ['₹30', '₹50', '₹75', '₹100', '₹150'],
    promos: [],
    message: '',
  );

  AddMoneyState copyWith({
    AddMoneyStatus Function()? status,
    String Function()? selectedAmount,
    String Function()? amount,
    String Function()? promoCode,
    List<String> Function()? quickAmounts,
    List<PromoModel> Function()? promos,
    String Function()? message,
  }) {
    return AddMoneyState(
      status: status != null ? status() : this.status,
      selectedAmount: selectedAmount != null
          ? selectedAmount()
          : this.selectedAmount,
      amount: amount != null ? amount() : this.amount,
      promoCode: promoCode != null ? promoCode() : this.promoCode,
      quickAmounts: quickAmounts != null ? quickAmounts() : this.quickAmounts,
      promos: promos != null ? promos() : this.promos,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [
    status,
    selectedAmount,
    amount,
    promoCode,
    quickAmounts,
    promos,
    message,
  ];
}
