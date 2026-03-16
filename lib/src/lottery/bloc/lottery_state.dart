part of 'lottery_bloc.dart';

enum LotteryStatus { initial, loading, loaded, failure }

class LotteryState extends Equatable {
  final LotteryStatus status;
  final String balance;
  final String selectedState;
  final int currentTabIndex;
  final List<GameModel> games;
  final List<GameModel> yzabcGames;
  final List<LotteryHistoryModel> history;
  final List<LotteryWinnerModel> winners;
  final List<LotteryQuickActionModel> quickActions;
  final List<LotteryFeatureModel> features;
  final List<String> availableStates;
  final String message;

  const LotteryState({
    required this.status,
    required this.balance,
    required this.selectedState,
    required this.currentTabIndex,
    required this.games,
    required this.yzabcGames,
    required this.history,
    required this.winners,
    required this.quickActions,
    required this.features,
    required this.availableStates,
    required this.message,
  });

  static const LotteryState initial = LotteryState(
    status: LotteryStatus.initial,
    balance: '0.00',
    selectedState: 'All',
    currentTabIndex: 0,
    games: [],
    yzabcGames: [],
    history: [],
    winners: [],
    quickActions: [],
    features: [],
    availableStates: [], // Will be loaded dynamically from repository
    message: '',
  );

  LotteryState copyWith({
    LotteryStatus Function()? status,
    String Function()? balance,
    String Function()? selectedState,
    int Function()? currentTabIndex,
    List<GameModel> Function()? games,
    List<GameModel> Function()? yzabcGames,
    List<LotteryHistoryModel> Function()? history,
    List<LotteryWinnerModel> Function()? winners,
    List<LotteryQuickActionModel> Function()? quickActions,
    List<LotteryFeatureModel> Function()? features,
    List<String> Function()? availableStates,
    String Function()? message,
  }) {
    return LotteryState(
      status: status != null ? status() : this.status,
      balance: balance != null ? balance() : this.balance,
      selectedState: selectedState != null
          ? selectedState()
          : this.selectedState,
      currentTabIndex: currentTabIndex != null
          ? currentTabIndex()
          : this.currentTabIndex,
      games: games != null ? games() : this.games,
      yzabcGames: yzabcGames != null ? yzabcGames() : this.yzabcGames,
      history: history != null ? history() : this.history,
      winners: winners != null ? winners() : this.winners,
      quickActions: quickActions != null ? quickActions() : this.quickActions,
      features: features != null ? features() : this.features,
      availableStates: availableStates != null
          ? availableStates()
          : this.availableStates,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [
    status,
    balance,
    selectedState,
    currentTabIndex,
    games,
    yzabcGames,
    history,
    winners,
    quickActions,
    features,
    availableStates,
    message,
  ];
}
