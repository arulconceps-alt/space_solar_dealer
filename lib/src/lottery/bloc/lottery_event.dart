part of 'lottery_bloc.dart';

sealed class LotteryEvent extends Equatable {
  const LotteryEvent();

  @override
  List<Object> get props => [];
}

class InitializeLottery extends LotteryEvent {
  const InitializeLottery();
}

class SelectState extends LotteryEvent {
  final String state;

  const SelectState({required this.state});

  @override
  List<Object> get props => [state];
}

class SelectTab extends LotteryEvent {
  final int tabIndex;

  const SelectTab({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class LoadGames extends LotteryEvent {
  const LoadGames();
}

class LoadHistory extends LotteryEvent {
  const LoadHistory();
}

class ResetLotteryMessage extends LotteryEvent {
  const ResetLotteryMessage();
}
